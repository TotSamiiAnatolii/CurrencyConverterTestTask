//
//  SelectCurrencyModel.swift
//  CurrencyConverter
//
//  Created by APPLE on 23.05.2023.
//

import Foundation

struct SelectCurrencyModel {
    let listCurrency: [String]
    var isCurrency: String
    var onAction: ((String) -> Void)
}
