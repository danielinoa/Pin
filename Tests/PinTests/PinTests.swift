import XCTest
@testable import Pin

final class PinTests: XCTestCase {

    func testActivatingChainCreatesConstraintsOnParentView() {
        let parentView = UIView()
        let childView = UIView()
        _ = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        ).activate()
        XCTAssertEqual(parentView.constraints.count, 3)
    }

    func testDeactivatingChainRemovesAllConstraintsOnParentView() {
        let parentView = UIView()
        let childView = UIView()
        let chain = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        )
        chain.activate()
        XCTAssertEqual(parentView.constraints.count, 3)
        chain.deactivate()
        XCTAssertEqual(parentView.constraints.count, .zero)
    }

    func testActivatingChainAdds2SubviewsOnParentView() {
        let parentView = UIView()
        let subview1 = UIView()
        let subview2 = UIView()
        _ = parentView.add(
            subview1.pin(to: .centerY, .leading, .trailing),
            subview2.pin(to: .edges)
        ).activate()
        XCTAssertEqual(parentView.subviews.count, 2)
        XCTAssertEqual(parentView.subviews.first, subview1)
        XCTAssertEqual(parentView.subviews.last, subview2)
    }

    func testDeactivatingChainRemoves2SubviewsFromParentView() {
        let parentView = UIView()
        let subview1 = UIView()
        let subview2 = UIView()
        let chain = parentView.add(
            subview1.pin(to: .centerY, .leading, .trailing),
            subview2.pin(to: .edges)
        )
        chain.activate()
        XCTAssertEqual(parentView.subviews.count, 2)
        XCTAssertEqual(parentView.subviews.first, subview1)
        XCTAssertEqual(parentView.subviews.last, subview2)
        chain.deactivate()
        XCTAssertEqual(parentView.subviews.count, .zero)
    }
}
