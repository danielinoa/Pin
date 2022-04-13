//
//  Created by Daniel Inoa on 4/12/22.
//

import UIKit

extension Pinnable  {

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func stack(_ pinnables: Pinnable...) -> Pinnable where Self: UIStackView {
        add(pinnables).contain(using: { [weak self] in
            self?.addArrangedSubview($0.view)
        })
    }
}
