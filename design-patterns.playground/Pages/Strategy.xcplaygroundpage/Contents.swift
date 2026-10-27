//: [Observer](@previous)

//    Strategy
//    Strategy is a behavioral design pattern that defines a family of interchangeable algorithms
//    and lets the context pick or swap one at run time without changing its own code.

protocol Strategy {
    func execute()
}

class FastestRoute: Strategy {
    func execute() {
        print("taking the fastest route!")
    }
}

class ShortestRoute: Strategy {
    func execute() {
        print("taking the shortest route!")
    }
}

// The context always has a strategy: it is injected through init and can be swapped later.
class Driving {
    var strategy: Strategy

    init(strategy: Strategy) {
        self.strategy = strategy
    }

    func executeStrategy() {
        strategy.execute()
    }
}

let driving = Driving(strategy: FastestRoute())
driving.executeStrategy()
driving.strategy = ShortestRoute()
driving.executeStrategy()
