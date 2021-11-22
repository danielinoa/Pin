//
//  Created by Daniel Inoa on 12/22/20.
//

import UIKit

extension UIView: Pinnable {
    public var view: UIView { self }
    public var children: [Pinnable] { [] }
    public var superResolvables: [SuperResolvable] { [] }
    public var selfResolvables: [SelfResolvable] { [] }
}
