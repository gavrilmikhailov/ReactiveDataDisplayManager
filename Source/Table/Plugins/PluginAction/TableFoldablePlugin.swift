//
//  TableFoldablePlugin.swift
//  ReactiveDataDisplayManager
//
//  Created by Никита Коробейников on 28.01.2021.
//  Copyright © 2021 Александр Кравченков. All rights reserved.
//

/// Plugin to support `FoldableItem`
///
/// Allow  expand or collapse child cells
public class TableFoldablePlugin: BaseTablePlugin<TableEvent> {

    // MARK: - BaseTablePlugin

    public override func process(event: TableEvent, with manager: BaseTableManager?) {
        switch event {
        case .didSelect(let indexPath):
            guard
                let generator = manager?.generators[indexPath.section][indexPath.row],
                let foldable = generator as? FoldableItem & TableCellGenerator,
                let foldingManager = manager as? FoldingTableManager
            else {
                return
            }

            if foldable.isExpanded {
                foldingManager.collapseGenerator(foldable)
            } else {
                foldingManager.expandGenerator(foldable)
            }
        default:
            break
        }
    }

}

// MARK: - Public init

public extension BaseTablePlugin {

    /// Plugin to support `FoldableItem`
    ///
    /// Allow  expand or collapse child cells
    static func foldable() -> TableFoldablePlugin {
        .init()
    }

}
