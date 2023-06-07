import XCTest
@testable import Pin

final class PinTests: XCTestCase {

    func testActivatingTreeCreatesConstraintsOnParentView() {
        let parentView = UIView()
        let childView = UIView()
        _ = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        ).activate()
        XCTAssertEqual(parentView.constraints.count, 3)
    }

    func testDeactivatingTreeRemovesAllConstraintsOnParentView() {
        let parentView = UIView()
        let childView = UIView()
        let tree = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        )
        tree.activate()
        XCTAssertEqual(parentView.constraints.count, 3)
        tree.deactivate()
        XCTAssertEqual(parentView.constraints.count, .zero)
    }

    func testActivatingTreeAdds2SubviewsOnParentView() {
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

    func testDeactivatingTreeRemoves2SubviewsFromParentView() {
        let parentView = UIView()
        let subview1 = UIView()
        let subview2 = UIView()
        let tree = parentView.add(
            subview1.pin(to: .centerY, .leading, .trailing),
            subview2.pin(to: .edges)
        )
        tree.activate()
        XCTAssertEqual(parentView.subviews.count, 2)
        XCTAssertEqual(parentView.subviews.first, subview1)
        XCTAssertEqual(parentView.subviews.last, subview2)
        tree.deactivate()
        XCTAssertEqual(parentView.subviews.count, .zero)
    }

    func testSubviewOutsideOfTreeIsNotRemovedFromSuperviewAfterDeactivatingTree() {
        let parentView = UIView()
        let insideSubview = UIView()
        let outsideSubview = UIView()
        let tree = parentView.add(
            insideSubview.pin(to: .edges)
        )
        tree.activate()
        parentView.addSubview(outsideSubview)
        XCTAssertEqual(parentView.subviews.count, 2)
        XCTAssertEqual(parentView.subviews.first, insideSubview)
        XCTAssertEqual(parentView.subviews.last, outsideSubview)
        tree.deactivate()
        XCTAssertEqual(parentView.subviews.count, 1)
        XCTAssertEqual(parentView.subviews.first, outsideSubview)
        XCTAssertEqual(parentView.subviews.last, outsideSubview)
    }

    func testTranslatesAutoresizingMaskIntoConstraintsIsOffInChildViewAfterActivatingTree() {
        let parentView = UIView()
        let childView = UIView()
        let tree = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        )
        tree.activate()
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
    }

    func testTranslatesAutoresizingMaskIntoConstraintsIsOnInChildViewAfterDeactivatingTree() {
        let parentView = UIView()
        let childView = UIView()
        let tree = parentView.add(
            childView.pin(to: .centerY, .leading, .trailing)
        )
        tree.activate()
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        tree.deactivate()
        XCTAssertTrue(childView.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Custom Containment

    func testCustomContainmentStrategyIsExecuted() {
        var containmentCount: Int = .zero
        let parentView = UIView()
        let childView = UIView()
        let tree = parentView.contain { child in
            parentView.addSubview(child.pinnableView)
            containmentCount += 1
        }.add(
            childView.pin(to: .centerY, .leading, .trailing)
        )
        tree.activate()
        XCTAssertEqual(containmentCount, 1)
    }
}
