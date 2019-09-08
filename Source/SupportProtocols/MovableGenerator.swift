import Foundation

/// Описывает генератор, который можно интерактивно перемещать.
public protocol MovableGenerator {
    func canMove() -> Bool
}
