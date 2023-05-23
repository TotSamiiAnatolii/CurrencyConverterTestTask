//
//  ModelRatesCurrency.swift
//  CurrencyConverter
//
//  Created by APPLE on 22.05.2023.
//

import Foundation


struct RatesModel: Decodable {
    let status: Int
    let message: String
    let data: [String: String]
}


