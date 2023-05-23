//
//  CurrencyCache.swift
//  CurrencyConverter
//
//  Created by APPLE on 23.05.2023.
//

import Foundation

final class CurrencyCache {
    
    private let timeIntervalMinute: Int = 20
    
    private var previusDate: Date
    
    private var currencyRateCache: [String: RatesModel] = [:]
    
    init(previusDate: Date) {
        self.previusDate = previusDate
    }
    
    private func updateCache() {
        let currenctDate = Date()
        let timePassed = currenctDate.offsetFrom(date: previusDate)
        if timePassed > timeIntervalMinute {
            previusDate = currenctDate
        }
    }
    
    func setCache(_ value: [String: RatesModel]) {
        guard let key = value.keys.first else {
            return
        }
        
        let valueCurrency = value[key]
        if currencyRateCache[key] == nil {
            currencyRateCache[key] = valueCurrency
        }
    }
    
    func returnData(key: String) -> RatesModel? {
        updateCache()
        return currencyRateCache[key]
    }
}

