//
//  Created by Daniel Inoa on 12/22/20.
//

import UIKit

extension UIView: Pinnable {
    public var view: UIView { self }
    public var children: [Pinnable] { .empty }
    public var superResolvables: [SuperResolvable] { .empty }
    public var selfResolvables: [SelfResolvable] { .empty }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables)
    }

    /// Adds the specified Pinnables.
    public func add(_ pinnables: [Pinnable]) -> Pinnable {
        contain(pinnables, containmentStrategy: { self.addSubview($0.view) })
    }
}
