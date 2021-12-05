//
//  Created by Daniel Inoa on 1/3/21.
//

import UIKit

extension Pinnable {

    /// Centers the view between the specified top and bottom anchors.
    /// - Parameters:
    ///   - top: The top-most vertical anchor.
    ///   - bottom: The bottom-most vertical anchor.
    /// - Returns: The Pinnable node that centers associated view.
    public func center(between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) -> Pinnable {
        appending(Center(view, between: top, and: bottom))
    }

    /// Centers the view between the specified leading and trailing anchors.
    /// - Parameters:
    ///   - leading: The top-most horizontal anchor.
    ///   - trailing: The trailing-most horizontal anchor.
    /// - Returns: The Pinnable node that centers associated view.
    public func center(between leading: NSLayoutXAxisAnchor, and trailing: NSLayoutXAxisAnchor) -> Pinnable {
        appending(Center(view, between: leading, and: trailing))
    }
}

private final class Center: SuperResolvable {

    /// The reference layout guide the view is centered against.
    private let guide = UILayoutGuide()

    /// The list of constraints associated with centering the view.
    private let constraints: [NSLayoutConstraint]

    /// Initializes a super-resolvable `Center` instance.
    /// - Parameters:
    ///   - view: The view to be vertically centered.
    ///   - top: The top-most vertical anchor.
    ///   - bottom: The bottom-most vertical anchor.
    public init(_ view: UIView, between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) {
        constraints = [
            guide.topAnchor.constraint(equalTo: top),
            guide.bottomAnchor.constraint(equalTo: bottom),
            view.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ]
    }

    /// Initializes a super-resolvable `Center` instance.
    /// - Parameters:
    ///   - view: The view to be horizontally centered.
    ///   - leading: The top-most horizontal anchor.
    ///   - trailing: The trailing-most horizontal anchor.
    public init(_ view: UIView, between leading: NSLayoutXAxisAnchor, and trailing: NSLayoutXAxisAnchor) {
        constraints = [
            guide.leadingAnchor.constraint(equalTo: leading),
            guide.trailingAnchor.constraint(equalTo: trailing),
            view.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
        ]
    }

    public func resolve(with superview: UIView) {
        superview.addLayoutGuide(guide)
        constraints.activate()
    }

    public func revert(with superview: UIView) {
        constraints.deactivate()
        superview.removeLayoutGuide(guide)
    }
}
