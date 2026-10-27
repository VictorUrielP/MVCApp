//: [Factory Method](@previous)

//    Observer
//    Observer is a behavioral design pattern that lets an object (the subject) notify a list of
//    subscribers whenever its state changes, without knowing their concrete types.

protocol Subscriber: AnyObject {
    func notify(_ news: String)
}

protocol NewsAgency {
    func addObserver(_ subscriber: Subscriber)
    func removeObserver(_ subscriber: Subscriber)
    func setNews(_ news: String)
}

// Holds a subscriber weakly so the agency never keeps it alive.
struct WeakSubscriber {
    weak var value: Subscriber?
}

class CNN: NewsAgency {
    private var subscribers: [WeakSubscriber] = []

    func addObserver(_ subscriber: Subscriber) {
        subscribers.append(WeakSubscriber(value: subscriber))
    }

    func removeObserver(_ subscriber: Subscriber) {
        subscribers.removeAll { $0.value == nil || $0.value === subscriber }
    }

    func setNews(_ news: String) {
        subscribers.removeAll { $0.value == nil }
        subscribers.forEach {
            $0.value?.notify(news)
        }
    }
}

class User: Subscriber {
    let name: String

    init(name: String) {
        self.name = name
    }

    func notify(_ news: String) {
        print("\(name) read: \(news)")
    }
}

let cnn = CNN()
let ana = User(name: "Ana")
var bob: User? = User(name: "Bob")

cnn.addObserver(ana)
cnn.addObserver(bob!)
cnn.setNews("Good weather today!")  // Ana read: ... / Bob read: ...

bob = nil                           // CNN doesn't keep Bob alive
cnn.setNews("Rain tomorrow")        // Ana read: Rain tomorrow

cnn.removeObserver(ana)
cnn.setNews("Nobody hears this")    // prints nothing

//: [Strategy](@next)
