import Foundation

open class PaginableBaseTableDataDisplayManager: BaseTableDataDisplayManager {

    /// Called if table shows last cell
    public var lastCellShowingEvent = BaseEvent<Void>()

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellGenerators[indexPath.section].count - 1 {
            lastCellShowingEvent.invoke(with: ())
        }
    }

}
