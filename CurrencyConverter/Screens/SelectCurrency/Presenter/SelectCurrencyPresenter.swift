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
    
    func sсrollTable()
    
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
        model.onAction(currency)
        model.isCurrency = currency
    }
    
    func map(model: [String]) -> [ModelSelectCurrencyCell] {
        return model.map { currency in
            ModelSelectCurrencyCell(
                codeCurrency: currency)
        }
    }
    
    func sсrollTable() {
        guard let row = findIndexSelectedElement(model) else { return }
        view?.sсrollTable(indexPath: IndexPath(row: row, section: .zero))
    }
    
    func findIndexSelectedElement(_ model: SelectCurrencyModel) -> Int? {
        guard let index = model.listCurrency.firstIndex(of: model.isCurrency) else {
            return nil
        }
        return index
    }
}
