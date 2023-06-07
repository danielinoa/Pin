//
//  Created by Daniel Inoa on 10/29/21.
//

extension Pinnable {

    /// The default containment strategy: `UIView.addSubview`.
    public var containmentStrategy: ContainmentStrategy {
        { pinnableView.addSubview($0.pinnableView) }
    }

    // MARK: - Default Containment

    /// Adds the specified Pinnables.
    public func add(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables)
    }

    /// Adds the specified Pinnables.
    public func add(@PinnableBuilder _ build: () -> PinnableBuilderResult) -> Pinnable {
        add(build().flattened())
    }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: [Pinnable]) -> Pinnable {
        BasePinnable(
            view: pinnableView,
            children: pinnableChildren + pinnables,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }

    // MARK: - Custom Containment

    /// Sets the specified `containmentStrategy` to contain the child Pinnables.
    public func contain(using containmentStrategy: @escaping ContainmentStrategy) -> Pinnable {
        BasePinnable(
            view: pinnableView,
            children: pinnableChildren,
            selfResolvables: selfResolvables,
            superResolvables: superResolvables,
            containmentStrategy: containmentStrategy
        )
    }
}
