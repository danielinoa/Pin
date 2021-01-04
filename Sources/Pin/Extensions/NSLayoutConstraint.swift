//
//  Created by Daniel Inoa on 12/8/20.
//

import UIKit

extension NSLayoutConstraint {
    
    public func activate() {
        isActive = true
    }
    
    public func deactivate() {
        isActive = false
    }
    
    @discardableResult
    public func setPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension NSLayoutConstraint: SelfResolvable {

    public func resolve() {
        activate()
    }

    public func revert() {
        deactivate()
    }
}

extension Array where Element == NSLayoutConstraint {
    
    @discardableResult
    public func activate() -> Self {
        forEach { $0.activate() }
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self {
        forEach { $0.deactivate() }
        return self
    }
}
