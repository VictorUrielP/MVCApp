//: [Flyweight](@previous)

//    Factory Method
//    Factory Method is a creational design pattern that defines an interface for creating an object,
//    but lets the conforming types decide which concrete type to create.
//    Client code depends only on the abstractions (Car, CarFactory), never on Sedan directly.

protocol Car {
    var type: String { get }
}

protocol CarFactory {
    func makeCar() -> Car
}

class Sedan: Car {
    var type: String {
        "Sedan"
    }
}

class SedanFactory: CarFactory {
    func makeCar() -> Car {
        return Sedan()
    }
}

struct Example {
    let factory: CarFactory

    func run() {
        let car = factory.makeCar()
        print(car.type)
    }
}

let example = Example(factory: SedanFactory())
example.run()

//: [Observer](@next)
