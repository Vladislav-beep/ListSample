//
//  UITableViewCell+Extensions.swift
//  List
//
//  Created by Владислав Сизонов on 04.02.2023.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    var reuseIdentifier: String {
        type(of: self).reuseIdentifier
    }
}
