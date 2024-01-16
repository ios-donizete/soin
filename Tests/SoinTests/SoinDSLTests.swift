//
//  File.swift
//  
//
//  Created by Donizete Vida on 15/01/24.
//

import XCTest
@testable import Soin

final class SoinDSLTests: XCTestCase {
    func testDSLFactory() throws {
        let container = soinContainer {
            soinFactory(Foo.init)
        }

        let foo1: Foo? = container.poop()
        let foo2: Foo? = container.poop()
        
        assert(foo1 != nil)
        assert(foo2 != nil)
        assert(foo1 !== foo2)
    }
    
    func testDSLSingleton() throws {
        let container = soinContainer {
            soinSingleton(Foo.init)
        }

        let foo1: Foo? = container.poop()
        let foo2: Foo? = container.poop()
        
        assert(foo1 != nil)
        assert(foo2 != nil)
        assert(foo1 === foo2)
    }
    
    func testDSLDependencyBuild() {
        let container = soinContainer {
            soinFactory(Foo.init)
            soinFactory(Bar.init)
        }

        let bar: Bar? = container.poop()
        assert(bar != nil)
    }
    
    func testDSLSingletonByName() throws {
        let container = soinContainer {
            soinSingleton(Foo.init, "v1")
            soinSingleton(Foo.init, "v2")
        }

        let foo1v1: Foo? = container.poop("v1")
        let foo2v1: Foo? = container.poop("v1")
        
        let foo1v2: Foo? = container.poop("v2")
        let foo2v2: Foo? = container.poop("v2")
        
        assert(foo1v1 != nil && foo2v1 != nil)
        assert(foo1v1 === foo2v1)
        
        assert(foo1v2 != nil && foo2v2 != nil)
        assert(foo1v2 === foo2v2)
        
        assert(foo1v1 !== foo1v2)
        assert(foo2v1 !== foo2v2)
    }
}
