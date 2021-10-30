//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

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
