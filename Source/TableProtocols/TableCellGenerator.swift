import Foundation

/// Абстракция над ячейкой для адаптера.
/// Должна использоваться для:
/// - Создания UITableViewCell
/// - Сохранения состояния ячейки
/// - Инкапсуляции логики определения параметров ячейки (нужных для таблицы)
///
/// ---
///
/// Используется в связке с `ViewBuilder`
public protocol TableCellGenerator: class {

    /// Высота ячейки для UITableViewCell.
    ///
    /// По-умолчанию возвращает UITableView.automaticDimension
    ///
    /// - Warning: Это свойство нужно для `UITableViewDelegate` и не обязано возвращать реальную высоту.
    var cellHeight: CGFloat { get }

    /// Предполагаемый размер ячейки.
    ///
    /// По-умолчанию возвращает nil
    ///
    /// - Warning: Это свойство нужно для `UITableViewDelegate` и не обязано возвращать реальную высоту.
    var estimatedCellHeight: CGFloat? { get }

    /// Идентификатор ячейки.
    /// Будет использован для регистрации ячейки.
    var identifier: UITableViewCell.Type { get }

    /// Создает ячейку для таблицы.
    ///
    /// - Parameter tableView: Таблица, в окторую нужно поместить ячейку из этого генератора.
    /// - Return: Ячейка для таблицы.
    func generate(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell

    /// Регистрирует ячейку в таблице.
    ///
    /// - Parameter in: Таблица, в которой нужно зарегистрировать ячейку.
    func registerCell(in tableView: UITableView)
}

public extension TableCellGenerator {

    var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }

    var estimatedCellHeight: CGFloat? {
        return nil
    }

}

public extension TableCellGenerator where Self: ViewBuilder {

    func generate(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier.nameOfClass, for: indexPath) as? Self.ViewType else {
            return UITableViewCell()
        }

        self.build(view: cell)

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func registerCell(in tableView: UITableView) {
        tableView.registerNib(self.identifier)
    }

}
