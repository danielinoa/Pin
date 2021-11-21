//
//  Created by Daniel Inoa on 1/4/21.
//

import UIKit
import SwiftPlus

/// The base concrete implementation of the Pinnable. It serves as the default container node in a Pinnable tree.
final class BasePinnable: Pinnable {

    let view: UIView
    let children: [Pinnable]
    let containmentStrategy: Callback<Pinnable>
    private(set) var selfResolvables: [SelfResolvable]
    private(set) var superResolvables: [SuperResolvable]

    init(
        view: UIView,
        children: [Pinnable],
        selfResolvables: [SelfResolvable],
        superResolvables: [SuperResolvable],
        containmentStrategy: @escaping Callback<Pinnable>
    ) {
        self.view = view
        self.children = children
        self.selfResolvables = selfResolvables
        self.superResolvables = superResolvables
        self.containmentStrategy = containmentStrategy
    }
}
