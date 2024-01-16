import XCTest
@testable import Soin

final class SoinTests: XCTestCase {
    func testFactory1() throws {
        let container = SoinContainer()
        container.factory(BazImpl.init)

        let foo1: Foo? = container.poop()
        let foo2: Foo? = container.poop()
        
        assert(foo1 != nil)
        assert(foo2 != nil)
        assert(foo1 !== foo2)
    }
}
