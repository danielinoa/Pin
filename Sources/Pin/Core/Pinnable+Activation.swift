//
//  Created by Daniel Inoa on 10/29/21.
//

// MARK: - Activation

extension Pinnable {

    /// Resolves and activates all the constraints under this tree.
    @discardableResult
    public func activate() -> Pinnable {

        // Activate children's super-resolvables
        children.forEach { child in
            child.view.translatesAutoresizingMaskIntoConstraints = false
            (self as? BasePinnable)?.containmentStrategy(child)
            child.superResolvables.resolve(with: view)
            child.activate()
        }

        // Activate self-resolvables
        selfResolvables.resolve()

        return self
    }

    /// Reverts and deactivates all the constraints under this tree.
    @discardableResult
    public func deactivate() -> Pinnable {
        selfResolvables.revert()
        children.forEach { child in
            child.view.translatesAutoresizingMaskIntoConstraints = true
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
}
