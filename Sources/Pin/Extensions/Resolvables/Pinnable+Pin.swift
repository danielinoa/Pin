//
//  Created by Daniel Inoa on 10/30/21.
//

import UIKit

extension Pinnable {

    /// Pins the view's non-margin attributes to the specified superview's attributes.
    /// - The specified `padding` is adjusted to push the view towards the opposite edge for the `bottom`, `trailing`,
    /// and `right` attributes.
    public func pin(
        to attributes: NSLayoutConstraint.Attribute...,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        padding: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        pin(to: attributes, relation: relation, multiplier: multiplier, padding: padding, priority: priority)
    }

    /// Pins the view's non-margin attributes to the specified superview's attributes.
    /// - The specified `padding` is adjusted to push the view towards the opposite edge for the `bottom`, `trailing`,
    /// and `right` attributes.
    public func pin(
        to attributes: [NSLayoutConstraint.Attribute],
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        padding: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let pin = Pin(
            view: view, to: attributes, relation: relation, multiplier: multiplier, padding: padding, priority: priority
        )
        return appending(pin)
    }
}

private final class Pin: SuperResolvable {

    private var constraints: [NSLayoutConstraint] = []
    private let constraintProviders: [(UIView) -> NSLayoutConstraint]

    init(
        view: UIView,
        to attributes: [NSLayoutConstraint.Attribute],
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        padding: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) {
        constraintProviders = attributes.map { attribute in
            let adjustedPadding = Self.semanticConstant(padding, for: attribute)
            let nonMarginAttribute = Self.nonMarginAttribute(for: attribute)
            return { superview in
                /// This closure captures `self` (the concrete Pinnable object) in order to access `view`.
                /// This however will not create a reference cycle because `self` does not end up owning this closure.
                /// The closure is ultimately owned by the last Pinnable object that is created in the Pinnable chain, typically the owning parent.
                /// The same mechanism exists in `subviewingAction`, `subview(...)`, `stack(...)`.
                NSLayoutConstraint(
                    item: view,
                    attribute: nonMarginAttribute,
                    relatedBy: relation,
                    toItem: superview,
                    attribute: attribute,
                    multiplier: multiplier,
                    constant: adjustedPadding
                )
                .setPriority(priority)
            }
        }
    }

    /// Returns a padding value that pushes an object against the edge of the specified attribute.
    /// - For positive values `trailing` and `trailingMargin` attributes move the layout towards the leading edge in left-to-right layouts.
    /// - For positive values `right` and `rightMargin` attributes move the layout towards the left edge in left-to-right layouts.
    /// - For positive values `bottom` and `bottomMargin` attributes move the layout towards the top edge in left-to-right layouts.
    private static func semanticConstant(
        _ constant: CGFloat, for attribute: NSLayoutConstraint.Attribute
    ) -> CGFloat {
        switch attribute {
        case .trailing, .trailingMargin, .right, .rightMargin, .bottom, .bottomMargin: return -constant
        default: return constant
        }
    }

    /// Returns the non-margin equivalent of the specified attribute.
    /// - Note: Passing `.leadingMargin` or `.leading` returns `.leading`.
    private static func nonMarginAttribute(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint.Attribute {
        let marginAttribute: NSLayoutConstraint.Attribute
        switch attribute {
        case .leftMargin: marginAttribute = .left
        case .rightMargin: marginAttribute = .right
        case .leadingMargin: marginAttribute = .leading
        case .trailingMargin: marginAttribute = .trailing
        case .topMargin: marginAttribute = .top
        case .bottomMargin: marginAttribute = .bottom
        case .centerXWithinMargins: marginAttribute = .centerX
        case .centerYWithinMargins: marginAttribute = .centerY
        default: marginAttribute = attribute
        }
        return marginAttribute
    }

    // MARK: - SuperResolvable

    func resolve(with superview: UIView) {
        constraints = constraintProviders.map { makeConstraint in makeConstraint(superview) }
        constraints.activate()
    }

    func revert(with superview: UIView) {
        constraints.deactivate()
        constraints = []
    }
}
