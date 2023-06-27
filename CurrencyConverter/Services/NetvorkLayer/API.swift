//
//  API.swift
//  CurrencyConverter
//
//  Created by APPLE on 22.05.2023.
//

import UIKit

enum ApiUrl: String {
    case key = "&key=1f8704cf780eeaf40e68ba31dadb2b5a"
    case listCurrency = "https://currate.ru/api/?get=currency_list"
    case rate = "https://currate.ru/api/?get=rates&pairs="
}
