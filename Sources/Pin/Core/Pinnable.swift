//
//  Created by Daniel Inoa on 12/17/20.
//

import UIKit
import SwiftPlus

// RESOURCES: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/DebuggingTricksandTips.html#//apple_ref/doc/uid/TP40010853-CH21-SW1

/// A type that can be contained and constrained, and provides modifiers to configure the layout of the associated view.
public protocol Pinnable {

    /// The view that constraints will be associated to.
    var view: UIView { get }

    /// The list of pinnable children.
    var children: [Pinnable] { get }

    /// The containment strategy to invoke when adding children pinnables or subviews.
    var containmentStrategy: Callback<Pinnable> { get }

    /// The constraints' closures that are to be resolved by this node's parent node.
    var superResolvables: [SuperResolvable] { get }

    /// The constraints' closures that are to be resolved by this node.
    var selfResolvables: [SelfResolvable] { get }
}

extension Pinnable {

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

    // MARK: - Extensibility

    /// Adds a new super-resolvable to the end of the list of super-resolvables.
    @discardableResult
    public func appending(_ superResolvables: SuperResolvable...) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: selfResolvables,
            superResolvables: self.superResolvables + superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    /// Adds a new self-resolvable to the end of the list of self-resolvables.
    @discardableResult
    public func appending(_ selfResolvables: SelfResolvable...) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: self.selfResolvables + selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    @discardableResult
    public func appending(_ contain: @escaping Callback<Pinnable>) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: contain
        )
    }
}
