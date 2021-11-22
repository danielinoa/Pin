//
//  Created by Daniel Inoa on 10/29/21.
//

import SwiftPlus

extension Pinnable {

    public typealias ContainmentStrategy = Callback<Pinnable>

    /// The containment strategy. For example: `UIView.addSubview`.
    public var containmentStrategy: ContainmentStrategy {
        { _ in fatalError("\(self) has no containment strategy.") }
    }

    // MARK: - Default Containment

    /// Adds the specified Pinnables.
    public func add(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables)
    }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: [Pinnable]) -> Pinnable {
        contain(pinnables, containmentStrategy: { view.addSubview($0.view) })
    }

    // MARK: - Custom Containment

    /// Adds the specified child Pinnables by setting and using the specified `containmentStrategy` strategy.
    public func contain(_ pinnables: [Pinnable], using: @escaping ContainmentStrategy) -> Pinnable {
        BasePinnable(
            view: view,
            children: children + pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    /// Set the specified `containmentStrategy` strategy to contain child Pinnables.
    @discardableResult
    public func contain(using: @escaping ContainmentStrategy) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }
}
