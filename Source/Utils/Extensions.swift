//
//  Extensions.swift
//  ReactiveDataDisplayManager
//
//  Created by Alexander Kravchenkov on 01.08.17.
//  Copyright © 2017 Alexander Kravchenkov. All rights reserved.
//

import Foundation
import UIKit

public extension NSObject {
    /// Получает имя класса.
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

public extension UITableView {

    /// Регистрирует ячейку по ее бандлу.
    /// В качестве ключа используется имя класса ячейки.
    ///
    /// - Parameter cellType: Тип ясейки для регистрации.
    func registerNib(_ cellType: UITableViewCell.Type) {
        self.register(UINib(nibName: cellType.nameOfClass, bundle: Bundle(for: cellType.self)), forCellReuseIdentifier: cellType.nameOfClass)
    }
}

public extension UICollectionView {
    
    /// Регистрирует ячейку по ее бандлу.
    /// В качестве ключа используется имя класса ячейки.
    ///
    /// - Parameter cellType: Тип ясейки для регистрации.
    func registerNib(_ cellType: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cellType.nameOfClass, bundle: Bundle(for: cellType.self)), forCellWithReuseIdentifier: cellType.nameOfClass)
    }
}
