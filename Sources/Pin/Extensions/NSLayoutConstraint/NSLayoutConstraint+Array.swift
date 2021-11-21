//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

extension Array where Element == NSLayoutConstraint {

    /// Activates all instances of `NSLayoutConstraint`.
    @discardableResult
    public func activate() -> Self {
        forEach { $0.activate() }
        return self
    }

    /// Deactivates all instances of `NSLayoutConstraint`.
    @discardableResult
    public func deactivate() -> Self {
        forEach { $0.deactivate() }
        return self
    }
}
