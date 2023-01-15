//
//  UITableView+Extension.swift
//  Trending
//
//  Created by Emre on 13.01.2023.
//

import UIKit

extension UITableView {

    func registerClass(named: AnyClass) {
        let className = String.init(describing: named)

        if Bundle.main.path(forResource: className, ofType: "nib") != nil {
            self.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        } else {
            self.register(named, forCellReuseIdentifier: className)
        }
    }

}
