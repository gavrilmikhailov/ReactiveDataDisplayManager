//
//  Operations.swift
//  ReactiveDataDisplayManager
//
//  Created by Alexander Kravchenkov on 09.02.2018.
//  Copyright © 2018 Александр Кравченков. All rights reserved.
//

import Foundation

public extension DataDisplayManager {

    /// Синтаксический сахар.
    /// Добавляет генератор в конец списка.
    ///
    /// - Parameters:
    ///   - left: Адаптер, в который нужно добавить генератор.
    ///   - right: Новый генератор.
    static func += (left: Self, right: CellGeneratorType) {
        left.addCellGenerator(right)
    }

    /// Синтаксический сахар.
    /// Добавляет коллекцию генераторов в конец списка.
    /// - Parameters:
    ///   - left: Адаптер, в который нужно добавить генераторы
    ///   - right: Список новых генераторов.
    static func += (left: Self, right: [CellGeneratorType]) {
        left.addCellGenerators(right)
    }
}
