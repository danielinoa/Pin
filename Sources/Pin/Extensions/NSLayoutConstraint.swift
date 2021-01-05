//
//  Created by Daniel Inoa on 12/8/20.
//

import UIKit

extension NSLayoutConstraint {
    
    public func activate() {
        isActive = true
    }
    
    public func deactivate() {
        isActive = false
    }
    
    @discardableResult
    public func setPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension NSLayoutConstraint: SelfResolvable {

    public func resolve() {
        activate()
    }

    public func revert() {
        deactivate()
    }
}

extension Array where Element == NSLayoutConstraint {
    
    @discardableResult
    public func activate() -> Self {
        forEach { $0.activate() }
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self {
        forEach { $0.deactivate() }
        return self
    }
}

extension NSLayoutConstraint.Attribute {

    /// The center along the both the x-axis and y-axis of the object’s alignment rectangle.
    public static var center: [NSLayoutConstraint.Attribute] {
        [.centerX, .centerY]
    }

    /// The leading, trailing, top, and bottom edges of the object's alignment rectangle.
    public static var edges: [NSLayoutConstraint.Attribute] {
        [.leading, .trailing, .top, .bottom]
    }

    /// The leadingMargin, trailingMargin, topMargin, and bottomMargin edges of the object's alignment rectangle.
    public static var marginEdges: [NSLayoutConstraint.Attribute] {
        [.leadingMargin, .trailingMargin, .topMargin, .bottomMargin]
    }
}
