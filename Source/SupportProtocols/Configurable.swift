import Foundation

/// Описывает view, которая конфигурируется с помощью модели.
public protocol Configurable where Self: UIView {

    /// Тип данных для конфигурации.
    associatedtype Model

    /// Конфигурирует view.
    ///
    /// - Parameter model: Данные для конфигурации.
    func configure(with model: Model)
}
