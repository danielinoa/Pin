//
//  Created by Daniel Inoa on 1/3/21.
//

import UIKit
import SwiftPlus

final class Center: SuperResolvable {

    private let guide = UILayoutGuide()
    private let constraints: [NSLayoutConstraint]

    init(_ view: UIView, between top: NSLayoutYAxisAnchor, and bottom: NSLayoutYAxisAnchor) {
        constraints = [
            guide.topAnchor.constraint(equalTo: top),
            guide.bottomAnchor.constraint(equalTo: bottom),
            view.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ]
    }

    init(_ view: UIView, between leading: NSLayoutXAxisAnchor, and trailing: NSLayoutXAxisAnchor) {
        constraints = [
            guide.leadingAnchor.constraint(equalTo: leading),
            guide.trailingAnchor.constraint(equalTo: trailing),
            view.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
        ]
    }

    func resolve(with superview: UIView) {
        superview.addLayoutGuide(guide)
        constraints.activate()
    }

    func revert(with superview: UIView) {
        constraints.deactivate()
        superview.removeLayoutGuide(guide)
    }
}
