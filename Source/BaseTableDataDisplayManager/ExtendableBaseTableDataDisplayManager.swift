import Foundation

open class ExtendableBaseTableDataDisplayManager: BaseTableDataDisplayManager {

    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderGenerators.isEmpty ? 1 : sectionHeaderGenerators.count
    }

}
