//
//  Created by Daniel Inoa on 12/26/20.
//

import UIKit
import SwiftPlus

/// Represents the future assembly and activation of a constraint (or set of constraints) for a view that satisfy its
/// layout requirements without a superview.
public protocol SelfResolvable {

    /// Create and/or activate constraints.
    func resolve()

    /// Deactivate constraints and clean-up layout guides (or any other artifacts).
    func revert()
}

extension Array: SelfResolvable where Element == SelfResolvable {
    
    public func resolve() {
        forEach { $0.resolve() }
    }
    
    public func revert() {
        forEach { $0.revert() }
    }
}
