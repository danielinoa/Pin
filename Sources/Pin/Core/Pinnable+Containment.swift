//
//  Created by Daniel Inoa on 10/29/21.
//

import SwiftPlus

extension Pinnable {

    // MARK: - Containment

    /// The default containment strategy. For example: UIView.addSubview.
    public var containmentStrategy: Callback<Pinnable> {
        { _ in fatalError("\(self) has no containment strategy.") }
    }

    /// Adds the specified Pinnables using the `contain` strategy.
    public func contain(_ pinnables: [Pinnable], containmentStrategy: @escaping Callback<Pinnable>) -> Pinnable {
        BasePinnable(
            view: view,
            children: children + pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    // MARK: - Default Containment

    /// Adds the specified Pinnables.
    public func add(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables)
    }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: [Pinnable]) -> Pinnable {
        contain(pinnables, containmentStrategy: { self.view.addSubview($0.view) })
    }
}
