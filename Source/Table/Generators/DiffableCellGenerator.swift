//
//  DiffableCellGenerator.swift
//  ReactiveDataDisplayManager
//
//  Created by korshunov on 25.02.2022.
//

import UIKit

open class DiffableCellGenerator<Cell: ConfigurableItem & UITableViewCell>: BaseCellGenerator<Cell>,
                                                                            IdOwner,
                                                                            DiffableItemSource where Cell.Model: Equatable {
    public let id: AnyHashable

    public var diffableItem: DiffableItem {
        .init(id: id, state: AnyEquatable(model))
    }

    public init(uniqueId: AnyHashable, with model: Cell.Model, registerType: CellRegisterType = .nib) {
        self.id = uniqueId
        super.init(with: model, registerType: registerType)
    }

}

extension StaticDataDisplayWrapper where Base: UITableViewCell & ConfigurableItem, Base.Model: Equatable {

    public func diffableGenerator(
        uniqueId: AnyHashable,
        with model: Base.Model,
        and registerType: CellRegisterType = .nib
    ) -> DiffableCellGenerator<Base> {
        .init(uniqueId: uniqueId, with: model, registerType: registerType)
    }

}

extension StaticDataDisplayWrapper where Base: UITableViewCell & ConfigurableItem, Base.Model: Equatable & IdOwner {

    public func diffableGenerator(
        with model: Base.Model,
        and registerType: CellRegisterType = .nib
    ) -> DiffableCellGenerator<Base> {
        .init(uniqueId: model.id, with: model, registerType: registerType)
    }

}
