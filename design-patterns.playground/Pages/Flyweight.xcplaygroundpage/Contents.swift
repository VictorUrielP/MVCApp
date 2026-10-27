//: [Singleton](@previous)

import Foundation

//    Flyweight
//    Flyweight is a structural design pattern that allows programs to support vast quantities of objects
//    by sharing the state they have in common (intrinsic state) instead of copying it into every object.
//    The state that differs per object (extrinsic state) is kept outside the flyweight.

// Intrinsic state: heavy, and identical for every tree of the same species.
final class TreeType {
    let name: String
    let color: String
    let texture: [UInt8]

    init(name: String, color: String) {
        self.name = name
        self.color = color
        self.texture = Array(repeating: 0, count: 1_000_000) // stands in for a large bitmap
        print("loading texture for \(name)")
    }

    func draw(atX x: Int, y: Int) {
        // render texture at (x, y)
    }
}

// Flyweight factory: hands out one shared TreeType per species.
final class TreeTypeFactory {
    private var types: [String: TreeType] = [:]

    var count: Int {
        types.count
    }

    func treeType(name: String, color: String) -> TreeType {
        let key = "\(name)-\(color)"
        if let type = types[key] {
            return type
        }
        let type = TreeType(name: name, color: color)
        types[key] = type
        return type
    }
}

// Extrinsic state: small, and unique to each tree.
struct Tree {
    let x: Int
    let y: Int
    let type: TreeType

    func draw() {
        type.draw(atX: x, y: y)
    }
}

let factory = TreeTypeFactory()
var forest: [Tree] = []

for index in 0..<1_000 {
    let type = index.isMultiple(of: 2)
        ? factory.treeType(name: "Oak", color: "green")
        : factory.treeType(name: "Pine", color: "dark green")
    forest.append(Tree(x: index % 100, y: index / 100, type: type))
}
// loading texture for Oak
// loading texture for Pine

forest.forEach { $0.draw() }

print(forest.count, "trees share", factory.count, "textures") // 1000 trees share 2 textures

//: [Factory Method](@next)
