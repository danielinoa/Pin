//
//  Created by Daniel Inoa on 12/17/20.
//

import UIKit
import SwiftPlus

// RESOURCES: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/DebuggingTricksandTips.html#//apple_ref/doc/uid/TP40010853-CH21-SW1

// TODO: Instead of returning a new BasePinnable instance at every step, mutate the current instance if possible.

/// A type that can be contained and constrained, and provides modifiers to configure the layout of the associated view.
public protocol Pinnable: class {

    /// The view that constraints will be associated with.
    var view: UIView { get }

    /// The list of pinnable children.
    var children: [Pinnable] { get }

    /// The containment strategy to invoke when adding subviews.
    var subviewingAction: Callback<Pinnable> { get }

    /// The constraints' resolvable closures that are to be resolved by this node's parent.
    var superResolvables: [SuperResolvable] { get }

    /// The constraints' resolvable closures that are to be resolved by this node.
    var selfResolvables: [SelfResolvable] { get }
}

extension Pinnable {

    // MARK: - Size

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
    public func size(height: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.heightAnchor.constraint(equalToConstant: height).setPriority(priority)
        )
    }

    // MARK: - Center

    /// Centers the view between the specified top and bottom anchors.
    public func center(between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) -> Pinnable {
        appending(Center(view, between: top, and: bottom))
    }

    /// Centers the view between the specified leading and trailing anchors.
    public func center(between leading: NSLayoutXAxisAnchor, and trailing: NSLayoutXAxisAnchor) -> Pinnable {
        appending(Center(view, between: leading, and: trailing))
    }

    // MARK: - Edges

    /// Pins the view to its superview's edges, padding the specified edges.
    public func pinToEdges(
        leading: CGFloat = .zero,
        trailing: CGFloat = .zero,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) -> Pinnable {
        self.pin(to: .leading, constant: leading)
            .pin(to: .trailing, constant: -trailing)
            .pin(to: .top, constant: top)
            .pin(to: .bottom, constant: -bottom)
    }

    /// Pins the view to its superview's margin edges, padding the specified edges.
    public func pinToMarginEdges(
        leading: CGFloat = .zero,
        trailing: CGFloat = .zero,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) -> Pinnable {
        self.pin(to: .leadingMargin, constant: leading)
            .pin(to: .trailingMargin, constant: -trailing)
            .pin(to: .topMargin, constant: top)
            .pin(to: .bottomMargin, constant: -bottom)
    }

    // MARK: - Base

    /// Pins the view's anchor to the specified anchor.
    public func pin<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        _ keyPath: KeyPath<UIView, Anchor>,
        to anchor: Anchor,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let constraint = view[keyPath: keyPath]
            .constraint(equalTo: anchor, constant: constant)
            .setPriority(priority)
        return appending(constraint)
    }

    /// Pins the view's anchor to its other specified anchor.
    public func pin<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        _ receiverKeyPath: KeyPath<UIView, Anchor>,
        to targetKeyPath: KeyPath<UIView, Anchor>,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let constraint = view[keyPath: receiverKeyPath]
            .constraint(equalTo: view[keyPath: targetKeyPath], constant: constant)
            .setPriority(priority)
        return appending(constraint)
    }

    /// Pins the view's non-margin attributes to the specified parent attributes.
    /// - The specified `constant` is adjusted to pushes towards the opposite edge for the `bottom`, `trailing`,
    /// and `right` attributes
    public func pin(
        to attributes: NSLayoutConstraint.Attribute...,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        pin(to: attributes, relatedBy: relation, multiplier: multiplier, constant: constant, priority: priority)
    }

    /// Pins the view's non-margin attributes to the specified parent attributes.
    /// - The specified `constant` is adjusted to pushes towards the opposite edge for the `bottom`, `trailing`,
    /// and `right` attributes
    public func pin(
        to attributes: [NSLayoutConstraint.Attribute],
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let resolvables: [SuperResolvable] = attributes.map { attribute in
            let adjustedConstant = semanticConstant(constant, for: attribute)
            let childAttribute = nonMarginAttribute(for: attribute)
            let resolvable = BaseSuperResolvable { [self] superview in
                /// This closure captures the concrete Pinnable object (`self`) when `view` is referenced.
                /// This however does not create a reference cycle because `self` does not end up owning this closure.
                /// The closure is ultimately owned by the last Pinnable object that is created in the Pinnable chain.
                /// This is the same mechanism in `subviewingAction`, `subview(...)`, `stack(...)`.
                NSLayoutConstraint(
                    item: view,
                    attribute: childAttribute,
                    relatedBy: relation,
                    toItem: superview,
                    attribute: attribute,
                    multiplier: multiplier,
                    constant: adjustedConstant
                )
                .setPriority(priority)
            }
            return resolvable
        }
        return appending(resolvables)
    }

    // MARK: - Containment

    /// The default containment strategy, UIView.addSubview().
    public var subviewingAction: Callback<Pinnable> {
        { self.view.addSubview($0.view) }
    }

    /// Adds the specified Pinnable's view using its `subviewingAction` strategy.
    public func subview(_ pinnables: Pinnable...) -> Pinnable {
        BasePinnable(
            view: view,
            children: children + pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            subviewingAction: subviewingAction
        )
    }

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func stack(
        _ pinnables: Pinnable...,
        alignment: UIStackView.Alignment = .fill,
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = .zero
    ) -> Pinnable where Self == UIStackView {
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        return BasePinnable(
            view: view,
            children: pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            subviewingAction: { [self] pinnable in
                self.addArrangedSubview(pinnable.view)
            }
        )
    }

    // MARK: - Activation

    /// Resolves and activates all the constraints under this tree.
    @discardableResult
    public func activate() -> Pinnable {
        // Activate self-resolvables
        selfResolvables.resolve()

        // Activate children's super-resolvables
        children.forEach { child in
            child.view.translatesAutoresizingMaskIntoConstraints = false
            subviewingAction(child)
            child.superResolvables.resolve(with: view)
            child.activate()
        }
        return self
    }

    /// Reverts and deactivates all the constraints under this tree.
    @discardableResult
    public func deactivate() -> Pinnable {
        view.translatesAutoresizingMaskIntoConstraints = true
        selfResolvables.revert()
        children.forEach { child in
            child.superResolvables.revert(with: view)
            child.view.removeFromSuperview()
        }
        return self
    }

    /// Invalidates and schedules constraint updates within the tree.
    @discardableResult
    public func invalidate() -> Pinnable {
        view.setNeedsUpdateConstraints()
        view.updateConstraints()
        return self
    }

    // MARK: - Helpers

    /// Returns the non-margin equivalent of the specified attribute.
    /// - Note: Passing `.leadingMargin` or `.leading` returns `.leading`.
    private func nonMarginAttribute(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint.Attribute {
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

    /// Returns a constant that pushes an object against the edge of the specified attribute.
    /// - For positive values `trailing` and `trailingMargin` attributes move the layout towards the leading edge in left-to-right layouts.
    /// - For positive values `right` and `rightMargin` attributes move the layout towards the left edge in left-to-right layouts.
    /// - For positive values `bottom` and `bottomMargin` attributes move the layout towards the top edge in left-to-right layouts.
    private func semanticConstant(
        _ constant: CGFloat, for attribute: NSLayoutConstraint.Attribute
    ) -> CGFloat {
        switch attribute {
        case .trailing, .trailingMargin, .right, .rightMargin, .bottom, .bottomMargin: return -constant
        default: return constant
        }
    }

    /// Adds a new super-resolvable to the end of the list of super-resolvables.
    @discardableResult
    private func appending(_ superResolvables: SuperResolvable...) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: selfResolvables,
            superResolvables: self.superResolvables + superResolvables,
            subviewingAction: subviewingAction
        )
    }

    /// Adds a new self-resolvable to the end of the list of self-resolvables.
    @discardableResult
    private func appending(_ selfResolvables: SelfResolvable...) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: self.selfResolvables + selfResolvables,
            superResolvables: superResolvables,
            subviewingAction: subviewingAction
        )
    }
}
