//
//  Created by Daniel Inoa on 12/22/20.
//

import UIKit

extension UIView: Pinnable {
    public var view: UIView { self }
    public var children: [Pinnable] { .empty }
    public var superResolvables: [SuperResolvable] { .empty }
    public var selfResolvables: [SelfResolvable] { .empty }
}
