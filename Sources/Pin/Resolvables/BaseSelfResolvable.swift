//
//  BaseSelfResolvable.swift
//  ConstraintsGraph
//
//  Created by Daniel Inoa on 1/2/21.
//

import UIKit
import SwiftPlus

final class BaseSelfResolvable: SelfResolvable {

    private var constraints: [NSLayoutConstraint] = []
    private let makeConstraints: Factory<[NSLayoutConstraint]>

    init(_ makeConstraints: @escaping Factory<[NSLayoutConstraint]>) {
        self.makeConstraints = makeConstraints
    }

    func resolve() {
        constraints = makeConstraints()
        constraints.activate()
    }

    func revert() {
        constraints.deactivate()
        constraints = .empty
    }
}
