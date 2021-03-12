//
//  SectionTitleHeaderGenerator.swift
//  ReactiveDataDisplayManagerExample
//
//  Created by Anton Eysner on 08.02.2021.
//  Copyright © 2021 Alexander Kravchenkov. All rights reserved.
//

import Foundation
import ReactiveDataDisplayManager
import UIKit

final class SectionTitleHeaderGenerator: TableHeaderGenerator, IndexTitleDisplaybleItem {

    // MARK: - Constants

    private enum Constants {
        static let defaultHeight: CGFloat = 30
    }

    // MARK: - Events

    var willDisplayEvent = BaseEvent<Void>()
    var didEndDisplayEvent = BaseEvent<Void>()
    var didEndDisplayCellEvent: BaseEvent<UITableViewCell>?

    // MARK: - Properties

    var title: String
    var needIndexTitle: Bool

    // MARK: - Private Property

    private let model: String
    private lazy var view = HeaderView().spmNib(bundle: Bundle.module)

    // MARK: - Initialization

    init(model: String, needSectionIndexTitle: Bool) {
        self.model = model
        self.title = model
        self.needIndexTitle = needSectionIndexTitle
    }

    // MARK: - TableHeaderGenerator

    override func generate() -> UIView {
        guard let view = view else { return UIView() }
        view.configure(with: model)
        return view
    }

    override func height(_ tableView: UITableView, forSection section: Int) -> CGFloat {
        view?.frame.height ?? Constants.defaultHeight
    }

}
