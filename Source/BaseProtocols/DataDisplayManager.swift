import Foundation

/// Описывает адаптер для коллекций.
/// Имеет реализации для `UITableVew` и `UICollectionView`.
/// Инкапсулирует логику работы с коллеций.
/// Все манипуляции с данными должны быть инкапсулировану внутрь такого обьъекта.
///
/// Все манипуляции с UIView так же должны быть инкапсулированы внутрь адаптера.
public protocol DataDisplayManager: class {

    // MARK:- Associatedtypes

    /// Тип коллекции, для которой работает адаптер.
    associatedtype CollectionType
    /// Тип генераторов ячеек, с которыми умеет работать адаптер.
    associatedtype CellGeneratorType
    /// Тип генераторов заголовков, с которыми умеет работать адаптер.
    associatedtype HeaderGeneratorType

    // MARK: - Init/deinit

    init(collection: CollectionType)

    // MARK: - Public Methods

    /// Полностью перезагружает все генераторы для данной коллекции.
    func forceRefill()

    /// Добавляет новый генератор заголовков в адаптер.
    ///
    /// - Parameter generator: Новый генератор.
    func addSectionHeaderGenerator(_ generator: HeaderGeneratorType)

    /// Добавляет новый генератор ячеек в адаптер.
    ///
    /// - Parameters:
    ///   - generator: Новый генератор.
    func addCellGenerator(_ generator: CellGeneratorType)

    /// Добавляет новый генератор в адаптер.
    ///
    /// - Parameters:
    ///   - generator: Новый генератор.
    ///   - after: Генератор, после которого (по списку) будет добавлен новый генератор.
    func addCellGenerator(_ generator: CellGeneratorType, after: CellGeneratorType)

    /// Добавляет список новых генераторов ячеек в адаптер.
    ///
    /// - Parameters:
    ///   - generator: Список новых генератор.
    func addCellGenerators(_ generators: [CellGeneratorType])

    /// Добавляет список новых генераторов ячеек в адаптер.
    ///
    /// - Parameters:
    ///   - generator: Список новых генераторов.
    ///   - after: Генератор, после которого (по списку) будут добавлены новый генераторы.
    func addCellGenerators(_ generators: [CellGeneratorType], after: CellGeneratorType)

    /// Перезагружает конкретные генераторы.
    ///
    /// - Parameter generators: Генераторы для обновления.
    func update(generators: [CellGeneratorType])

    /// Удаляет все генераторы заголовков.
    func clearHeaderGenerators()

    /// Удаляет все генераторы ячеек.
    func clearCellGenerators()
}
