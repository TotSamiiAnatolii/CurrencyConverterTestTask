//
//  ConverterCurrencyPresenter.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

protocol ConverterCurrencyPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var amount: Double { get set }
    
    func getRate(from: String, to: String)
    
    func calculate(_ value: String) -> Double
    
    func getListCurrency()
    
    func selectFromCurrency()
    
    func selectToCurrency()
    
    func setAmount(_ value: String)
    
    func beginValueInput() -> Bool
    
    func setToCodeCurrency(codeCurrency: String)
    
    func setFromCodeCurrency(codeCurrency: String)
    
    func setToСalculatedValue(_ total: Double)
    
    func setFromValue()
    
    func swapСurrencies()
    
    func refresh()
    
    func formatter(_ value: Double, count: Int) -> String
    
    func convertTextInNumerals(input: String?) -> Double
    
    func failure(error: Error)
}

final class ConverterCurrencyPresenter: ConverterCurrencyPresenterProtocol {
   
    weak var view: ConverterCurrencyController?
    
    var router: RouterProtocol
    
    var currencyParser = CurrencyParser()
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
        getListCurrency()
    }
    
    var listCurrency: [String: [String]] = [:]
    
    var fromCurrency: String = ""
    
    var toCurrency: String = ""
    
    var amount: Double = 0 {
        didSet{
            self.getRate(from: fromCurrency, to: toCurrency)
        }
    }
    
    var calculateValue: String = ""
    
    func selectFromCurrency() {
        let model = SelectCurrencyModel(
            listCurrency: listCurrency.keys.sorted(by: {$0 < $1}),
            isCurrency: self.fromCurrency) {[weak self] codeCurrency in
                self?.setFromCodeCurrency(codeCurrency: codeCurrency)
            }
        router.selectedCurency(model: model)
    }
    
    func selectToCurrency() {
        if fromCurrency.isEmpty {
            view?.noFromToСurrencySelected(view?.fromSelectCurrencyButton, nil)
            return
        }
        let model = SelectCurrencyModel(
            listCurrency: listCurrency[fromCurrency] ?? [],
            isCurrency: self.toCurrency) {[weak self] codeCurrency in
                self?.setToCodeCurrency(codeCurrency: codeCurrency)
            }
        router.selectedCurency(model: model)
    }
    
    func getRate(from: String, to: String) {
        self.networkService.getRates(from: from, to: to) { result in
            switch result {
            case .success(let success):
                self.networkService.currencyCache.setCache(["\(from)\(to)": success])
                let rate = success.data.values.first ?? ""
                self.setToСalculatedValue(self.calculate(rate))
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.failure(error: failure)
                }
            }
        }
    }
    
    func getListCurrency() {
        networkService.getListCurrency { result in
            switch result {
            case .success(let success):
                let data = self.currencyParser.decomposeCurrencyPair(success.data)
                self.listCurrency = self.currencyParser.parseListOfPairs(data)
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.failure(error: failure)
                }
            }
        }
    }
    
    func calculate(_ value: String) -> Double {
        let value = convertTextInNumerals(input: value)
        return amount * value
    }
    
    func swapСurrencies() {
        if fromCurrency.isEmpty && toCurrency.isEmpty {
            return
        }
        view?.setFromCurrencyCode(code: toCurrency)
        view?.setToCurrencyCode(code: fromCurrency)
        let currentCurrency = fromCurrency
        let toValue = view?.toValue.text
        fromCurrency = toCurrency
        toCurrency = currentCurrency
        
        setToСalculatedValue(amount)
        amount = convertTextInNumerals(input: toValue)
        
        setFromValue()
    }
    
    func setFromCodeCurrency(codeCurrency: String) {
        self.fromCurrency = codeCurrency
        view?.setFromCurrencyCode(code: fromCurrency)
    }
    
    func setToCodeCurrency(codeCurrency: String) {
        self.toCurrency = codeCurrency
        view?.setToCurrencyCode(code: toCurrency)
    }
    
    func refresh() {
        self.getRate(from: fromCurrency, to: toCurrency)
    }
    
    func setFromValue() {
        view?.setFromValue(formatter(amount, count: 2))
    }
    
    func setToСalculatedValue(_ total: Double) {
        view?.setCalculatedValue(formatter(total, count: 2))
    }
    
    func setAmount(_ value: String) {
        self.amount = convertTextInNumerals(input: value)
    }
    
    func beginValueInput() -> Bool {
        
        switch fromCurrency  {
        case _ where !fromCurrency.isEmpty && !toCurrency.isEmpty:
            if amount > 0 {
                view?.setFromValue(formatter(amount, count: 0))
            }
            return true
            
        case _ where fromCurrency.isEmpty && toCurrency.isEmpty:
            view?.noFromToСurrencySelected(view?.fromSelectCurrencyButton, view?.toSelectCurrencyButton)
            return false
            
        case _ where !fromCurrency.isEmpty && toCurrency.isEmpty:
            view?.noFromToСurrencySelected(nil, view?.toSelectCurrencyButton)
            return false
            
        case _ where fromCurrency.isEmpty && !toCurrency.isEmpty:
            view?.noFromToСurrencySelected(view?.fromSelectCurrencyButton, nil)
            return false
            
        default:
            return false
        }
    }
    
    func formatter(_ value: Double, count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.roundingMode = .up
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = count
        formatter.groupingSeparator = " "
        return formatter.string(from: value as NSNumber) ?? ""
    }
    
    func convertTextInNumerals(input: String?) -> Double {
        
        if let textWithoutSpaces = input?.replacingOccurrences(of: " ", with: "") {
            guard  let number = Formatter.formatterFrom.number(from: textWithoutSpaces) as? Double else { return 0 }
            return number
        }
        return 0
    }
    
    func failure(error: Error) {

        router.alert(title: "Error", message:  error.localizedDescription, btnTitle: "Повторить") {

        }
    }
}
