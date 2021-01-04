//
//  Created by Daniel Inoa on 1/4/21.
//

import UIKit
import SwiftPlus

final class BasePinnable: Pinnable {

    let view: UIView
    let children: [Pinnable]
    let subviewingAction: Callback<Pinnable>
    private(set) var selfResolvables: [SelfResolvable]
    private(set) var superResolvables: [SuperResolvable]

    init(
        view: UIView,
        children: [Pinnable],
        selfResolvables: [SelfResolvable],
        superResolvables: [SuperResolvable],
        subviewingAction: @escaping Callback<Pinnable>
    ) {
        self.view = view
        self.children = children
        self.selfResolvables = selfResolvables
        self.superResolvables = superResolvables
        self.subviewingAction = subviewingAction
    }
}
