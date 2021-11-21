//
//  Created by Daniel Inoa on 12/8/20.
//

import UIKit

extension NSLayoutConstraint {

    /// Activates the constraint.
    public func activate() {
        isActive = true
    }

    /// Deactivates the constraint.
    public func deactivate() {
        isActive = false
    }

    /// Assigns the specified `priority` to the constraint.
    @discardableResult
    public func setPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension NSLayoutConstraint: SelfResolvable {

    /// Resolves by activating the constraint.
    public func resolve() {
        activate()
    }

    /// Reverts by deactivating the constraint.
    public func revert() {
        deactivate()
    }
}
