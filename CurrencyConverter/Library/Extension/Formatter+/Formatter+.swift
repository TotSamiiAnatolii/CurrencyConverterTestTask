//
//  Formatter+.swift
//  CurrencyConverter
//
//  Created by APPLE on 23.05.2023.
//

import Foundation

extension Formatter {
        
    static let formatterFrom: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    
    var formatterFrom: String { Formatter.formatterFrom.string(for: self) ?? "" }

}
