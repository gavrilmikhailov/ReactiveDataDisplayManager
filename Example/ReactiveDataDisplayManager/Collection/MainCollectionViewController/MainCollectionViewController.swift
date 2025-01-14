//
//  MainCollectionViewController.swift
//  ReactiveDataDisplayManagerExample
//
//  Created by Vadim Tikhonov on 09.02.2021.
//  Copyright © 2021 Alexander Kravchenkov. All rights reserved.
//

import UIKit
import ReactiveDataDisplayManager

final class MainCollectionViewController: UIViewController {

    // MARK: - SegueIdentifiers

    fileprivate enum SegueIdentifier: String {
        case baseCollection
        case listAppearances
        case imageCollection
        case imageHorizontalCollection
        case prefetchingCollection
        case sizableCollection
        case foldableCollection
        case itemTitleCollection
        case diffableCollection
        case paginatableCollection
        case compositionalCollection
        case differenceCollection
        case swipeableListAppearances
        case movableCollection
        case dragAndDroppableCollection
        case carouselCollection
        case alignedCollection
        case dynamicHeightViewController
    }

    // MARK: - Constants

    private enum Constants {
        static let models: [(title: String, segueId: SegueIdentifier)] = [
            ("Base collection view", .baseCollection),
            ("List Appearances", .listAppearances),
            ("Gallery without prefetching", .imageCollection),
            ("Gallery with prefetching", .prefetchingCollection),
            ("Horizontal image collection", .imageHorizontalCollection),
            ("Sizable collection", .sizableCollection),
            ("Foldable collection", .foldableCollection),
            ("Collection with item index titles", .itemTitleCollection),
            ("Collection with diffableDataSource", .diffableCollection),
            ("Collection with pagination", .paginatableCollection),
            ("Collection with compositional layout", .compositionalCollection),
            ("Collection with DifferenceKit", .differenceCollection),
            ("List Appearances with swipeable items", .swipeableListAppearances),
            ("Collection with movable items", .movableCollection),
            ("Collection with drag and drop item", .dragAndDroppableCollection),
            ("Carousel collection view layout", .carouselCollection),
            ("Aligned collection layout", .alignedCollection),
            ("Dynamic height ViewController", .dynamicHeightViewController)
        ]
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private Properties

    private lazy var adapter = tableView.rddm.manualBuilder
        .add(plugin: .selectable())
        .build()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        fillAdapter()
    }

}

// MARK: - Private methods

private extension MainCollectionViewController {

    /// This method is used to fill adapter
    func fillAdapter() {
        for model in Constants.models {

            if model.segueId == .carouselCollection {
                adapter.addSectionHeaderGenerator(TitleHeaderGenerator(model: "Layout exapmple"))
            }

            // Create generator
            let generator = TitleWithIconTableViewCell.rddm.baseGenerator(with: model.title)

            generator.didSelectEvent += { [weak self] in
                self?.openScreen(by: model.segueId)
            }

            // Add generator to adapter
            adapter.addCellGenerator(generator)
        }

        // Tell adapter that we've changed generators
        adapter.forceRefill()
    }

    func openScreen(by segueId: SegueIdentifier) {
        switch segueId {
        case .listAppearances, .swipeableListAppearances:
            if #available(iOS 14.0, tvOS 14.0, *) {
                performSegue(withIdentifier: segueId.rawValue, sender: tableView)
            } else {
                showAlert("Available from 14 IOS")
            }
        default:
            performSegue(withIdentifier: segueId.rawValue, sender: tableView)
        }
    }

}
