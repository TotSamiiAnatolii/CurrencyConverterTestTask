//
//  CurrencyParser.swift
//  CurrencyConverter
//
//  Created by APPLE on 22.05.2023.
//

import Foundation

final class CurrencyParser {
    
    func decomposeCurrencyPair(_ currencyPair: [String]) -> [(String, String)] {
        var pair: [(String, String)] = []
        currencyPair.forEach { currencyPair in
            guard let currency = parseCurrencyPair(currencyPair) else {
                return
            }
            pair.append(currency)
        }
        return pair
    }
    
    private func parseCurrencyPair(_ input: String) -> (String, String)? {
        let currencyCodeCount = 3
        guard input.count >= currencyCodeCount * 2 else {
            return nil
        }
        return (
            String(input.prefix(currencyCodeCount)),
            String(input.suffix(currencyCodeCount))
        )
    }
    
    func parseListOfPairs(_ pairs: [(String, String)]) -> [String: [String]] {
        var resultDict: [String: [String]] = [:]
        
        pairs.forEach { (fromCur, toCur) in
            if resultDict[fromCur] == nil {
                resultDict[fromCur] = [toCur]
            } else {
                resultDict[fromCur]?.append(toCur)
            }
            
            if resultDict[toCur] == nil {
                resultDict[toCur] = [fromCur]
            } else {
                resultDict[toCur]?.append(fromCur)
            }
        }
        return resultDict
    }
}
