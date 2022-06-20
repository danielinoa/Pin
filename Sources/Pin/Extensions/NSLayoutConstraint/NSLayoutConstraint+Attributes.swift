//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

extension Array where Element == NSLayoutConstraint.Attribute {

    /// The width and height of the object’s alignment rectangle.
    public static var size: Self {
        [.width, .height]
    }

    /// The center along the both the x-axis and y-axis of the object’s alignment rectangle.
    public static var center: Self {
        [.centerX, .centerY]
    }


    /// The `top`, and `bottom` edges of the object's alignment rectangle.
    public static var verticalEdges: Self {
        [.top, .bottom]
    }

    /// The `leading` and `trailing` edges of the object's alignment rectangle.
    public static var horizontalEdges: Self {
        [.leading, .trailing]
    }

    /// The vertical and horizontal edges of the object's alignment rectangle.
    public static var edges: Self {
        verticalEdges + horizontalEdges
    }

    /// The `topMargin`, and `bottomMargin` edges of the object's alignment rectangle.
    public static var verticalMarginEdges: Self {
        [.topMargin, .bottomMargin]
    }

    /// The `leadingMargin` and `trailingMargin` edges of the object's alignment rectangle.
    public static var horizontalMarginEdges: Self {
        [.leadingMargin, .trailingMargin]
    }

    /// The vertical and horizontal margin edges of the object's alignment rectangle.
    public static var marginEdges: Self {
        verticalMarginEdges + horizontalMarginEdges
    }
}
