//
//  RefreshableTableViewController.swift
//  ReactiveDataDisplayManagerExample
//
//  Created by Никита Коробейников on 03.03.2021.
//  Copyright © 2021 Alexander Kravchenkov. All rights reserved.
//

import UIKit
import ReactiveDataDisplayManager

final class RefreshableTableViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private Properties

    private lazy var adapter = tableView.rddm.baseBuilder
        .add(plugin: .refreshable(refreshControl: UIRefreshControl(), output: self))
        .build()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table with refresh control"
        fillAdapter()
    }

}

// MARK: - Private Methods

private extension RefreshableTableViewController {

    /// This method is used to fill adapter
    func fillAdapter() {

        adapter -= .all

        for _ in 0...3 {
            adapter += makeGenerator()
        }

        adapter => .reload
    }

    func makeGenerator() -> TableCellGenerator {
        TitleTableViewCell.rddm.baseGenerator(with: "Random cell \(Int.random(in: 0...1000))" )
    }

}

// MARK: - RefreshableOutput

extension RefreshableTableViewController: RefreshableOutput {

    func refreshContent(with input: RefreshableInput) {
        delay(.now() + .seconds(3)) { [weak self, weak input] in
            self?.fillAdapter()

            input?.endRefreshing()
        }
    }

}
