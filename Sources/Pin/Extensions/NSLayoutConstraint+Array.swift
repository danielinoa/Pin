//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

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

extension Array where Element == NSLayoutConstraint.Attribute {

    /// The width and height of the object’s alignment rectangle.
    public static var size: Self {
        [.width, .height]
    }

    /// The center along the both the x-axis and y-axis of the object’s alignment rectangle.
    public static var center: Self {
        [.centerX, .centerY]
    }

    /// The leading, trailing, top, and bottom edges of the object's alignment rectangle.
    public static var edges: Self {
        [.leading, .trailing, .top, .bottom]
    }

    /// The leadingMargin, trailingMargin, topMargin, and bottomMargin edges of the object's alignment rectangle.
    public static var marginEdges: Self {
        [.leadingMargin, .trailingMargin, .topMargin, .bottomMargin]
    }
}
