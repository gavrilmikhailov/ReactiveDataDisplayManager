import UIKit

/// Описывает генератор, который можно удалить.
public protocol DeletableGenerator {
    var eventDelete: BaseEmptyEvent { get }
}
