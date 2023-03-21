//
//  Protocols.swift
//  VirtusaTest
//
//  Created by Mahendra Shivapurapu on 20/03/23.
//

import Foundation
import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String {get}
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifiable { }
