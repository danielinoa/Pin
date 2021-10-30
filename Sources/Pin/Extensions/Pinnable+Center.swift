//
//  Created by Daniel Inoa on 1/3/21.
//

import UIKit
import SwiftPlus

extension Pinnable {

    /// Centers the view between the specified top and bottom anchors.
    public func center(between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) -> Pinnable {
        appending(Center(view, between: top, and: bottom))
    }

    /// Centers the view between the specified leading and trailing anchors.
    public func center(between leading: NSLayoutXAxisAnchor, and trailing: NSLayoutXAxisAnchor) -> Pinnable {
        appending(Center(view, between: leading, and: trailing))
    }
}

public final class Center: SuperResolvable {

    private let guide = UILayoutGuide()
    private let constraints: [NSLayoutConstraint]

    public init(_ view: UIView, between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) {
        constraints = [
            guide.topAnchor.constraint(equalTo: top),
            guide.bottomAnchor.constraint(equalTo: bottom),
            view.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ]
    }

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
