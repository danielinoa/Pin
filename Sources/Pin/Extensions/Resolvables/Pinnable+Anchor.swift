//
//  Created by Daniel Inoa on 10/30/21.
//

import UIKit

extension Pinnable {

    /// Pins the view's anchor to the specified anchor.
    public func pin<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        _ keyPath: KeyPath<UIView, Anchor>,
        to anchor: Anchor,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let constraint = view[keyPath: keyPath]
            .constraint(equalTo: anchor, constant: constant)
            .setPriority(priority)
        return appending(constraint)
    }

    /// Pins the view's anchor to its other specified anchor.
    public func pin<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        _ receiverKeyPath: KeyPath<UIView, Anchor>,
        to targetKeyPath: KeyPath<UIView, Anchor>,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let constraint = view[keyPath: receiverKeyPath]
            .constraint(equalTo: view[keyPath: targetKeyPath], constant: constant)
            .setPriority(priority)
        return appending(constraint)
    }
}
