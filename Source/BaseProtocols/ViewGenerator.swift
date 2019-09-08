import UIKit

/// Protocol that incapsulated build logics for current View
public protocol ViewGenerator: class {

    associatedtype ViewType

    func generate() -> ViewType
}
