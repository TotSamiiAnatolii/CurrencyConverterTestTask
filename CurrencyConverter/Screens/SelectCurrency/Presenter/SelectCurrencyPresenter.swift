//
//  SelectCurrencyPresenter.swift
//  CurrencyConverter
//
//  Created by APPLE on 23.05.2023.
//

import UIKit

protocol SelectCurrencyPresenterProtocol {
    
    init(model: SelectCurrencyModel)
    
    var listCurrencyCell: [ModelSelectCurrencyCell] { get }
    
    var model: SelectCurrencyModel { get }
    
    func setCurrency(currency: String)
    
    func map(model: [String]) -> [ModelSelectCurrencyCell]
}

final class SelectCurrencyPresenter: SelectCurrencyPresenterProtocol {
    
    weak var view: SelectCurrencyViewProtocol?
    
    var model: SelectCurrencyModel
    
    var listCurrencyCell: [ModelSelectCurrencyCell] = []
    
    init(model: SelectCurrencyModel) {
        self.model = model
        listCurrencyCell = map(model: model.listCurrency)
    }
    
    func setCurrency(currency: String) {
        self.model.onAction(currency)
        self.model.isCurrency = currency
    }
    
    func map(model: [String]) -> [ModelSelectCurrencyCell] {
        return model.map { currency in
            ModelSelectCurrencyCell(
                codeCurrency: currency)
        }
    }
}
