//
//  Created by Daniel Inoa on 12/22/20.
//

import UIKit

extension UIView: Pinnable {

    /// The default implementation returns the view itself.
    public var view: UIView { self }

    /// The default implementation returns an empty list.
    public var children: [Pinnable] { [] }

    /// The default implementation returns an empty list.
    public var superResolvables: [SuperResolvable] { [] }

    /// The default implementation returns an empty list.
    public var selfResolvables: [SelfResolvable] { [] }
}
