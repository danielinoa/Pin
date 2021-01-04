//
//  Created by Daniel Inoa on 12/19/20.
//

import UIKit
import SwiftPlus

/// Represents the future assembly and activation of a constraint (or set of constraints) for a view that needs
/// its designated superview to satisfy its layout requirements.
public protocol SuperResolvable {

    /// Create and/or activate constraints.
    func resolve(with superview: UIView)

    /// Deactivate constraints and clean-up layout guides (or any other artifacts).
    func revert(with superview: UIView)
}

extension Array: SuperResolvable where Element == SuperResolvable {
    
    public func resolve(with superview: UIView) {
        forEach { $0.resolve(with: superview) }
    }
    
    public func revert(with superview: UIView) {
        forEach { $0.revert(with: superview) }
    }
}
