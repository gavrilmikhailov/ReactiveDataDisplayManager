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
    public func expandAllGenerators() {
        let allGenerators: [TableCellGenerator] = generators.flatMap { $0 }.filter {
            $0 is (FoldableItem & TableCellGenerator)
        }
        expandGenerators(allGenerators)
    }

    /// Collapse all generators
    ///
    public func collapseAllGenerators() {
        let allGenerators: [TableCellGenerator] = generators.flatMap { $0 }.filter {
            $0 is (FoldableItem & TableCellGenerator)
        }
        collapseGenerators(allGenerators)
    }

    /// Expands generators
    ///
    /// - Parameters:
    ///   - generators: generators signed `FoldableItem` and `TableCellGenerator`
    public func expandGenerators(_ generators: [TableCellGenerator]) {
        generators.forEach { expandGenerator($0) }
    }

    /// Collapse generators
    ///
    /// - Parameters:
    ///   - generators: generators signed `FoldableItem` and `TableCellGenerator`
    public func collapseGenerators(_ generators: [TableCellGenerator]) {
        generators.forEach { collapseGenerator($0) }
    }

    /// Expand generator
    ///
    /// - Parameters:
    ///   - generator: generator signed `FoldableItem` and `TableCellGenerator`
    public func expandGenerator(_ generator: TableCellGenerator, needScroll: Bool = false) {
        guard let foldingGenerator = generator as? FoldableItem, !foldingGenerator.isExpanded else {
            return
        }
        insert(after: generator, new: foldingGenerator.childGenerators, with: .bottom)
        foldingGenerator.isExpanded = !foldingGenerator.isExpanded
        foldingGenerator.didFold?(foldingGenerator.isExpanded)

        guard let index = findGenerator(generator), needScroll else {
            return
        }
        view.scrollToRow(at: .init(row: index.generatorIndex, section: index.sectionIndex), at: .top, animated: true)
    }

    /// Collapse generator
    ///
    /// - Parameters:
    ///   - generator: generator signed `FoldableItem` and `TableCellGenerator`
    public func collapseGenerator(_ generator: TableCellGenerator) {
        guard let foldingGenerator = generator as? FoldableItem, foldingGenerator.isExpanded else {
            return
        }
        foldingGenerator.childGenerators.forEach {
            remove($0,
                   with: .fade,
                   needScrollAt: nil,
                   needRemoveEmptySection: false)
        }
        foldingGenerator.isExpanded = !foldingGenerator.isExpanded
        foldingGenerator.didFold?(foldingGenerator.isExpanded)
    }

}
