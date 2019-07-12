//
//  StringLocalizable.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

protocol StringLocalizable {
    var tableName: String { get }
    var localized: String { get }
}

extension StringLocalizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
