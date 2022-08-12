//
//  Created by Daniel Inoa on 4/12/22.
//

import UIKit

extension Pinnable where Self: UIStackView  {

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func stack(_ pinnables: Pinnable...) -> Pinnable {
        stack(pinnables)
    }

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func _stack(@PinnableBuilder _ build: () -> PinnableBuilderResult) -> Pinnable {
        stack(build().flattened())
    }

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func stack(_ pinnables: [Pinnable]) -> Pinnable {
        add(pinnables).contain(using: { [weak self] in
            self?.addArrangedSubview($0.view)
        })
    }
}
