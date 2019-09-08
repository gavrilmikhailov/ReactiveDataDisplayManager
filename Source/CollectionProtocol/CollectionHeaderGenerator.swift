import Foundation

open class CollectionHeaderGenerator: ViewGenerator {

    /// Nib type, which create this generator
    open var identifier: String

    public required init(identifier: String) {
        self.identifier = identifier
    }

    open func generate() -> UICollectionReusableView {
        preconditionFailure("\(#function) must be overriden in child")
    }

}
