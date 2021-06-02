//
//  TableFoldablePlugin.swift
//  ReactiveDataDisplayManager
//
//  Created by Никита Коробейников on 28.01.2021.
//  Copyright © 2021 Александр Кравченков. All rights reserved.
//

public struct TableFoldablePluginConfig {

    var onlyOneExpanded: Bool
    var needScrollToExpanded: Bool

    public init(onlyOneExpanded: Bool, needScrollToExpanded: Bool) {
        self.onlyOneExpanded = onlyOneExpanded
        self.needScrollToExpanded = needScrollToExpanded
    }

    public static func defaultConfig() -> Self {
        return .init(onlyOneExpanded: false, needScrollToExpanded: false)
    }
}

/// Plugin to support `FoldableItem`
///
/// Allow  expand or collapse child cells
public class TableFoldablePlugin: BaseTablePlugin<TableEvent> {

    // MARK: - Private Properties

    private var config: TableFoldablePluginConfig

    // MARK: - Initialization

    public init(config: TableFoldablePluginConfig) {
        self.config = config
    }

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

            guard !foldable.isExpanded else {
                foldingManager.collapseGenerator(foldable)
                return
            }

            config.onlyOneExpanded ? foldingManager.collapseAllGenerators() : ()
            foldingManager.expandGenerator(foldable)

            guard config.needScrollToExpanded else {
                return
            }

            manager?.view.scrollToRow(at: indexPath, at: .top, animated: true)
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
    static func foldable(config: TableFoldablePluginConfig = TableFoldablePluginConfig.defaultConfig()) -> TableFoldablePlugin {
        .init(config: config)
    }

}
