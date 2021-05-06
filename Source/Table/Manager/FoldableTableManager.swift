//
//  FoldableTableManager.swift
//  ReactiveDataDisplayManager
//
//  Created by Влад Янковенко on 25.01.2021.
//  Copyright © 2021 Александр Кравченков. All rights reserved.
//

import Foundation

public final class FoldingTableManager: ManualTableManager {

    // MARK: - State Management Methods

    /// Expands all generators
    ///
    /// - Parameters:
    ///   - generators: generators signed `FoldableItem` and `TableCellGenerator`
    public func expandGenerators(_ generators: [(FoldableItem & TableCellGenerator)]) {
        generators.forEach { expandGenerator($0) }
    }

    /// Collapse all generators
    ///
    /// - Parameters:
    ///   - generators: generators signed `FoldableItem` and `TableCellGenerator`
    public func collapseGenerators(_ generators: [(FoldableItem & TableCellGenerator)]) {
        generators.forEach { collapseGenerator($0) }
    }

    /// Expand generator
    ///
    /// - Parameters:
    ///   - generator: generator signed `FoldableItem` and `TableCellGenerator`
    public func expandGenerator(_ generator: (FoldableItem & TableCellGenerator)) {
        guard !generator.isExpanded else {
            return
        }
        insert(after: generator, new: generator.childGenerators, with: .fade)
        generator.isExpanded = !generator.isExpanded
        generator.didFoldEvent.invoke(with: (generator.isExpanded))
    }

    /// Collapse generator
    ///
    /// - Parameters:
    ///   - generator: generator signed `FoldableItem` and `TableCellGenerator`
    public func collapseGenerator(_ generator: (FoldableItem & TableCellGenerator)) {
        guard generator.isExpanded else {
            return
        }
        generator.childGenerators.forEach {
            remove($0,
            with: .none,
            needScrollAt: nil,
            needRemoveEmptySection: false)
        }
        generator.isExpanded = !generator.isExpanded
        generator.didFoldEvent.invoke(with: (generator.isExpanded))
    }

}
