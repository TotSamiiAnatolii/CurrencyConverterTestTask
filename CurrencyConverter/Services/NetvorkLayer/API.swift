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
    
    static var listCurreny: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "currate.ru"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "get", value: "currency_list"),
            URLQueryItem(name: "key", value: "1f8704cf780eeaf40e68ba31dadb2b5a")]
        return components.url
    }
    
    static func rateCurrency(from: String, to: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "currate.ru"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "get", value: "rates"),
            URLQueryItem(name: "pairs", value: from + to),
            URLQueryItem(name: "key", value: "1f8704cf780eeaf40e68ba31dadb2b5a")]
        return components.url
    }
}
