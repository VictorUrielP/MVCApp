//: [Decorator](@previous)

import Foundation

//    Builder
//    The builder pattern separates the step-by-step construction of a complex object from the object itself.
//    The builder collects the parts, and build() returns the finished, immutable product.

enum Item: String {
    case burger = "Burger"
    case fries = "Fries"
    case coke = "Coke"
}

struct Order {
    let items: [Item]
    let notes: String?
}

final class OrderBuilder {
    private var items: [Item] = []
    private var notes: String?

    @discardableResult
    func add(_ item: Item) -> OrderBuilder {
        items.append(item)
        return self
    }

    @discardableResult
    func addBurger() -> OrderBuilder {
        add(.burger)
    }

    @discardableResult
    func addFries() -> OrderBuilder {
        add(.fries)
    }

    @discardableResult
    func addCoke() -> OrderBuilder {
        add(.coke)
    }

    @discardableResult
    func notes(_ notes: String) -> OrderBuilder {
        self.notes = notes
        return self
    }

    func build() -> Order {
        Order(items: items, notes: notes)
    }
}

let order = OrderBuilder()
    .addBurger()
    .addFries()
    .addFries()
    .add(.coke)
    .notes("No ice")
    .build()

print(order.items.map(\.rawValue), order.notes ?? "") // ["Burger", "Fries", "Fries", "Coke"] No ice


//    Composite
//    The composite design pattern composes objects into a tree structure and lets clients
//    treat individual objects and groups of objects through the same interface.

protocol MenuComponent {
    var name: String { get }
    var price: Double { get }
}

struct MenuItem: MenuComponent {
    let name: String
    let price: Double
}

struct Combo: MenuComponent {
    let name: String
    let children: [MenuComponent]
    let discount: Double

    var price: Double {
        children.reduce(0) { $0 + $1.price } - discount
    }
}

let burger = MenuItem(name: "Burger", price: 5.0)
let fries = MenuItem(name: "Fries", price: 2.5)
let coke = MenuItem(name: "Coke", price: 1.5)

let kidsCombo = Combo(name: "Kids combo", children: [burger, coke], discount: 1.0)
let familyCombo = Combo(name: "Family combo", children: [kidsCombo, kidsCombo, burger, fries], discount: 2.0)

// A single item, a combo and a combo of combos are all used the same way.
let menu: [MenuComponent] = [fries, kidsCombo, familyCombo]
menu.forEach { print($0.name, $0.price) }
// Fries 2.5
// Kids combo 5.5
// Family combo 16.5

//: [Flyweight](@next)
