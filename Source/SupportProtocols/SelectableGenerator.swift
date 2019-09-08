import UIKit

/// Описывает генератор, который можно выделить.
public protocol SelectableGenerator: class {

    /// Вызывается когда генератор становится выделенным (например по тапу пользователя)
    var didSelectEvent: BaseEvent<Void> { get }

    /// Определяет, нужно ли убирать выделение.
    ///
    /// Если значение `true` (по-умолчанию), тогда выделение сбросится сразу (поведение по-умолчанию).
    /// В противном случае ячейка останется выделенной.
    var isNeedDeselect: Bool { get }
}

public extension SelectableGenerator {
    var isNeedDeselect: Bool {
        return true
    }
}
