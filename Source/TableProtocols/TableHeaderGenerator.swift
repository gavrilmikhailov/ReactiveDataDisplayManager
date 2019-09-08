import UIKit

/// Генератор для заголовков таблицы.
/// Подобен `TableCellGenerator`.
open class TableHeaderGenerator: ViewGenerator {

    public init() { }

    /// Создает UIViev как заголовок для таблицы.
    ///
    /// - Warning: Реализация по-умолчанию вызывает `fatalError`
    ///
    /// - Returns: Возвращает заголовок.
    open func generate() -> UIView {
        fatalError("\(#function) must be overriden in child")
    }

    /// Возвращает высоту для заголовка.
    ///
    /// - Parameters:
    ///   - tableView: Таблица для которой генерируется ячейка.
    ///   - section: Секция в таблице для которой генерируется заголовок.
    ///
    /// - Warning: Реализация по-умолчанию вызывает `fatalError`
    ///
    /// - Returns: Высота.
    open func height(_ tableView: UITableView, forSection section: Int) -> CGFloat {
        fatalError("\(#function) must be overriden in child")
    }
}
