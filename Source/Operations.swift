import Foundation

public extension DataDisplayManager {

    /// Синтаксический сахар.
    /// Добавляет генератор в конец списка.
    ///
    /// - Parameters:
    ///   - left: Адаптер, в который нужно добавить генератор.
    ///   - right: Новый генератор.
    static func += (left: Self, right: CellGeneratorType) {
        left.addCellGenerator(right)
    }

    /// Синтаксический сахар.
    /// Добавляет коллекцию генераторов в конец списка.
    /// - Parameters:
    ///   - left: Адаптер, в который нужно добавить генераторы
    ///   - right: Список новых генераторов.
    static func += (left: Self, right: [CellGeneratorType]) {
        left.addCellGenerators(right)
    }
}
