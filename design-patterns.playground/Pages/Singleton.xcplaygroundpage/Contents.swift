//: [Builder](@previous)

import Foundation

//    Singleton
//    Singletons to provide a globally accessible, shared instance of a class.
//    You can create your own singletons as a way to provide a unified access point to a resource or service that’s shared across an app,
//    like an audio channel to play sound effects or a network manager to make HTTP requests.

class Singleton {
    
    // swift static instances are lazy initialized
    static let shared = Singleton()
    
    static let sharedWithConfiguration: Singleton = {
        let instance = Singleton()
        // setup code
        instance.name = "Shared instance across application"
        return instance
    }()
    
    var name: String
    
    private init() {
        self.name = "(no-name)"
    }
}

print(Singleton.shared.name)

print(Singleton.sharedWithConfiguration.name)

//: [Flyweight](@next)
