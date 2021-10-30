//
//  Created by Daniel Inoa on 10/29/21.
//

import UIKit

extension Pinnable {

    /// Sizes the view's width and height to the specified value.
    public func size(square value: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        size(width: value, height: value, priority: priority)
    }

    /// Sizes the view to the specified width and height.
    public func size(width: CGFloat, height: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.widthAnchor.constraint(equalToConstant: width).setPriority(priority),
            view.heightAnchor.constraint(equalToConstant: height).setPriority(priority)
        )
    }

    /// Sizes the view to the specified width.
    public func size(width: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.widthAnchor.constraint(equalToConstant: width).setPriority(priority)
        )
    }

    /// Sizes the view to the specified height.
    public func size(height: CGFloat, priority: UILayoutPriority = .required) -> Pinnable {
        appending(
            view.heightAnchor.constraint(equalToConstant: height).setPriority(priority)
        )
    }
}
