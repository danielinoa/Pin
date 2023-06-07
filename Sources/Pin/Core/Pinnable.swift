//
//  Created by Daniel Inoa on 12/17/20.
//

import UIKit

/// A type that can be contained and constrained, and provides modifiers to configure the layout of the associated view.
public protocol Pinnable {

    /// The view that constraints will be associated to.
    var pinnableView: UIView { get }

    /// The list of pinnable children.
    var pinnableChildren: [Pinnable] { get }

    /// The constraints' closures that are to be resolved by this node.
    var selfResolvables: [SelfResolvable] { get }

    /// The constraints' closures that are to be resolved by this node's parent node.
    var superResolvables: [SuperResolvable] { get }

    /// The containment strategy to invoke when adding children pinnables or subviews.
    var containmentStrategy: ContainmentStrategy { get }
}

extension Pinnable {

    /// Adds a new super-resolvable to the end of the list of super-resolvables.
    @discardableResult
    public func appending(_ superResolvables: SuperResolvable...) -> Pinnable {
        BasePinnable(
            view: pinnableView,
            children: pinnableChildren,
            selfResolvables: selfResolvables,
            superResolvables: self.superResolvables + superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    /// Adds a new self-resolvable to the end of the list of self-resolvables.
    @discardableResult
    public func appending(_ selfResolvables: SelfResolvable...) -> Pinnable {
        BasePinnable(
            view: pinnableView,
            children: pinnableChildren,
            selfResolvables: self.selfResolvables + selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }
}
