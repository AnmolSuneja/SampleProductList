//
//  ReuseableInterface.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import Foundation

protocol ReuseableInterface {
    static var reuseIdentifier: String { get }
}

extension ReuseableInterface {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
