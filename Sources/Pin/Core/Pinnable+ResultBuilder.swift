//
//  Created by Daniel Inoa on 2/12/22.
//

import UIKit

extension Pinnable {

    /// Adds the specified Pinnables.
    public func add(@PinnableBuilder _ build: () -> PinnableBuilderResult) -> Pinnable {
        let result = build().flattened()
        return add(result)
    }
}

@resultBuilder
public enum PinnableBuilder {

    public static func buildBlock(_ components: Pinnable...) -> PinnableBuilderResult {
        .init(pinnables: components)
    }

    public static func buildExpression(_ component: Pinnable) -> PinnableBuilderResult {
        .init(pinnables: [component])
    }

    public static func buildEither(first component: Pinnable) -> PinnableBuilderResult {
        .init(pinnables: [component])
    }

    public static func buildEither(second component: Pinnable) -> PinnableBuilderResult {
        .init(pinnables: [component])
    }

    public static func buildOptional(_ component: Pinnable?) -> PinnableBuilderResult {
        .init(pinnables: component.map { [$0] } ?? [])
    }
}

/// The container type to aggregate the `PinnableBuilder` results.
/// This type only conforms to `Pinnable` in order to be used as input or output in a resultBuilder's build-expression,
/// and not to be used within a `Pinnable` tree.
public struct PinnableBuilderResult: Pinnable {

    public var view: UIView { fatalError("PinnableBuilderResult is not be used as a Pinnable") }
    public var children: [Pinnable] { fatalError("PinnableBuilderResult is not be used as a Pinnable") }
    public var superResolvables: [SuperResolvable] { fatalError("PinnableBuilderResult is not be used as a Pinnable") }
    public var selfResolvables: [SelfResolvable] { fatalError("PinnableBuilderResult is not be used as a Pinnable") }

    fileprivate let pinnables: [Pinnable]

    fileprivate init(pinnables: [Pinnable]) {
        self.pinnables = pinnables
    }
}

fileprivate extension PinnableBuilderResult {

    /// Returns a `Pinnable` array, where instances of `PinnableBuilderResult` are recursively replaced
    /// with its underlying `pinnables`.
    func flattened() -> [Pinnable] {
        pinnables.flatMap { pinnable -> [Pinnable] in
            guard let builder = pinnable as? PinnableBuilderResult else { return [pinnable] }
            return builder.flattened()
        }
    }
}
