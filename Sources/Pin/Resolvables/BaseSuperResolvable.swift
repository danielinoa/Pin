//
//  Created by Daniel Inoa on 1/3/21.
//

import UIKit
import SwiftPlus

final class BaseSuperResolvable: SuperResolvable {

    private var constraints: [NSLayoutConstraint] = []
    private let makeConstraints: Map<UIView, [NSLayoutConstraint]>

    init(_ makeConstraints: @escaping Map<UIView, [NSLayoutConstraint]>) {
        self.makeConstraints = makeConstraints
    }

    convenience init(_ transform: @escaping Map<UIView, NSLayoutConstraint>) {
        self.init { [transform($0)] }
    }

    func resolve(with superview: UIView) {
        constraints = makeConstraints(superview)
        constraints.activate()
    }

    func revert(with superview: UIView) {
        constraints.deactivate()
        constraints = .empty
    }
}
