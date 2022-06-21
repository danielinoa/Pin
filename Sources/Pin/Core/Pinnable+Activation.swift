//
//  Created by Daniel Inoa on 10/29/21.
//

// MARK: - Activation

extension Pinnable {

    /// Resolves and activates all the constraints under this root node.
    @discardableResult
    public func activate() -> Pinnable {
        // Since it's possible to create a constraint with 2 views at different places in the tree, then there is the
        // possibility that activating said constraint will trigger an exception. This can occur if one of the views
        // is being referenced during the activation of a constraint but it has not yet been added as a subview under
        // their common ancestor.
        // To prevent this issue all views are added to the view-hierarchy first, and only after are the nodes resolved.
        composeViewTree()
        resolveResolvables()
        return self
    }

    private func composeViewTree() {
        children.forEach { child in
            child.view.translatesAutoresizingMaskIntoConstraints = false
            (self as? BasePinnable)?.containmentStrategy(child)
            child.composeViewTree()
        }
    }

    private func resolveResolvables() {
        // Activate children's super-resolvables
        children.forEach { child in
            child.superResolvables.resolve(with: view)
            child.resolveResolvables()
        }

        // Activate self-resolvables
        selfResolvables.resolve()
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
