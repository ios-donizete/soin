import XCTest
@testable import Soin

class Engine {
    init() {
        
    }
    
    func callAsFunction() {
        print("tu tu tu tu")
    }
}

class Car {
    let engine: Engine
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    func callAsFunction() {
        engine()
        print("Run run")
    }
}

// XCTest Documentation
// https://developer.apple.com/documentation/xctest

// Defining Test Cases and Test Methods
// https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

final class SoinTests: XCTestCase {
    func testASimpleFactory() throws {
        let container = SoinContainer()
        
        container.factory { c in Engine() }

        let engine1: Engine? = container.poop()
        let engine2: Engine? = container.poop()

        assert(engine1 != nil)
        assert(engine2 != nil)
        assert(engine1 !== engine2)
    }
    
    func testASimpleSingleton() throws {
        let container = SoinContainer()
        
        container.singleton { c in Engine() }

        let engine1: Engine? = container.poop()
        let engine2: Engine? = container.poop()

        assert(engine1 != nil)
        assert(engine2 != nil)
        assert(engine1 === engine2)
    }

    func testSimpleDSL() {
        let container = SoinContainer()

        container.singleton(Engine.init)
        container.singleton(Car.init)

        let car: Car? = container()
        assert(car != nil)
    }
}
