//
//  Created by Daniel Inoa on 10/29/21.
//

extension Pinnable {

    /// The default containment strategy: `UIView.addSubview`.
    public var containmentStrategy: ContainmentStrategy {
        { view.addSubview($0.view) }
    }

    // MARK: - Default Containment

    /// Adds the specified Pinnables.
    public func add(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables)
    }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: [Pinnable]) -> Pinnable {
        BasePinnable(
            view: view,
            children: children + pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    // MARK: - Custom Containment

    /// Sets the specified `containmentStrategy` to contain the child Pinnables.
    public func contain(using containmentStrategy: @escaping ContainmentStrategy) -> Pinnable {
        BasePinnable(
            view: view,
            children: children,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }
}
