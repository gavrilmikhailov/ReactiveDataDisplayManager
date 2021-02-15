//
//  BaseCollectionDataSource.swift
//  ReactiveDataDisplayManager
//
//  Created by Vadim Tikhonov on 09.02.2021.
//  Copyright © 2021 Александр Кравченков. All rights reserved.
//

import Foundation

protocol CollectionDataSource: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    var provider: CollectionGeneratorsProvider? { get set }
    var prefetchPlugins: PluginCollection< BaseCollectionPlugin <PrefetchEvent>> { get set }
    var collectionPlugins: PluginCollection< BaseCollectionPlugin <CollectionEvent>> { get set }
}

public protocol CollectionGeneratorsProvider: AnyObject {
    var generators: [[CollectionCellGenerator]] { get set }
    var sections: [CollectionHeaderGenerator] { get set }
}

extension BaseCollectionManager: CollectionGeneratorsProvider { }


// Base implementation for UICollectionViewDataSource protocol. Use it if NO special logic required.
open class BaseCollectionDataSource: NSObject {

    // MARK: - Properties

    weak var provider: CollectionGeneratorsProvider?

    var prefetchPlugins = PluginCollection<BaseCollectionPlugin<PrefetchEvent>>()
    var collectionPlugins = PluginCollection<BaseCollectionPlugin<CollectionEvent>>()

}

// MARK: - UICollectionViewDataSource

extension BaseCollectionDataSource: CollectionDataSource {

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return provider?.sections.count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let provider = provider, provider.generators.indices.contains(section) else {
            return 0
        }
        return provider.generators[section].count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let provider = provider else {
            return UICollectionViewCell()
        }
        return provider
            .generators[indexPath.section][indexPath.row]
            .generate(collectionView: collectionView, for: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let provider = provider else {
            return UICollectionReusableView()
        }
        return provider
            .sections[indexPath.section]
            .generate(collectionView: collectionView, for: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        collectionPlugins.process(event: .move(from: sourceIndexPath, to: destinationIndexPath), with: provider as? BaseCollectionManager)
    }

    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }

}

extension BaseCollectionDataSource: UICollectionViewDataSourcePrefetching {

    open func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchPlugins.process(event: .prefetch(indexPaths), with: provider as? BaseCollectionManager)
    }

    open func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        prefetchPlugins.process(event: .cancelPrefetching(indexPaths), with: provider as? BaseCollectionManager)
    }

}