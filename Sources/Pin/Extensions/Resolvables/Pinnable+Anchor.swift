//
//  Created by Daniel Inoa on 10/30/21.
//

import UIKit

extension Pinnable {

    /// Pins the view's anchor to the specified anchor. The specified anchor can belong to another view.
    /// - Parameters:
    ///   - receiverKeyPath: The view's anchor key path.
    ///   - targetAnchor: The anchor the view's anchor will be pinned to.
    /// - Returns: The Pinnable node that pins the associated view's anchor to the specified anchor.
    public func pin<AnchorType, Anchor: NSLayoutAnchor<AnchorType>>(
        _ receiverKeyPath: KeyPath<UIView, Anchor>,
        to targetAnchor: Anchor,
        constant: CGFloat = .zero,
        priority: UILayoutPriority = .required
    ) -> Pinnable {
        let constraint = view[keyPath: receiverKeyPath]
            .constraint(equalTo: targetAnchor, constant: constant)
            .setPriority(priority)
        return appending(constraint)
    }

    /// Pins the view's anchor to its other specified anchor.
    /// - Parameters:
    ///   - receiverKeyPath: The view's anchor key path.
    ///   - targetKeyPath: The view's second anchor key path the view's first anchor key path will be pinned to.
    /// - Returns: The Pinnable node that pins the associated view's anchor to its other anchor.
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
