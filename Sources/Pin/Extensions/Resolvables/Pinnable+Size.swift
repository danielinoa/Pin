//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

extension Pinnable {

    /// Sizes the view's width and height to the specified value.
    public func size(square value: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        size(width: value, height: value, priority: priority)
    }

    /// Sizes the view to the specified width and height.
    public func size(width: CGFloat, height: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.widthAnchor.constraint(equalToConstant: width).setPriority(priority),
            view.heightAnchor.constraint(equalToConstant: height).setPriority(priority)
        )
    }

    /// Sizes the view to the specified width.
    public func size(width: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.widthAnchor.constraint(equalToConstant: width).setPriority(priority)
        )
    }

    /// Sizes the view to the specified height.
    public func size(
        height: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required
    ) -> Pinnable {
        appending(
            size(attribute: .height, relation: relation, priority: priority, constant: height)
        )
    }

    /// Sizes the view to the specified height.
    public func size(
        width: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required
    ) -> Pinnable {
        appending(
            size(attribute: .width, relation: relation, priority: priority, constant: width)
        )
    }

    private func size(
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        .init(
            item: view,
            attribute: attribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant
        )
        .setPriority(priority)
    }
}
