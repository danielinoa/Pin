//
//  Created by Daniel Inoa on 1/4/21.
//

import UIKit

/// The base concrete implementation of the Pinnable. It serves as the default container node in a Pinnable tree.
final class BasePinnable: Pinnable {

    /// The view that constraints will be associated to.
    let view: UIView

    /// The list of pinnable children.
    let children: [Pinnable]

    /// The constraints' closures that are to be resolved by this node.
    private(set) var selfResolvables: [SelfResolvable]

    /// The constraints' closures that are to be resolved by this node's parent node.
    private(set) var superResolvables: [SuperResolvable]

    /// The containment strategy to invoke when adding children pinnables or subviews.
    let containmentStrategy: ContainmentStrategy

    init(
        view: UIView,
        children: [Pinnable],
        selfResolvables: [SelfResolvable],
        superResolvables: [SuperResolvable],
        containmentStrategy: @escaping ContainmentStrategy
    ) {
        self.view = view
        self.children = children
        self.selfResolvables = selfResolvables
        self.superResolvables = superResolvables
        self.containmentStrategy = containmentStrategy
    }
}
