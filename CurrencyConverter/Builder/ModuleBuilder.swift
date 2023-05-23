//
//  ModuleBuilder.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createConverterCurrency(router: RouterProtocol) -> UIViewController
    func createSelectedCurrency(router: RouterProtocol, model: SelectCurrencyModel) -> UIViewController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
    
    func createConverterCurrency(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkManager()
        let presenter = ConverterCurrencyPresenter(networkService: networkService, router: router)
        let view = ConverterCurrencyController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createSelectedCurrency(router: RouterProtocol, model: SelectCurrencyModel) -> UIViewController {
        let presenter = SelectCurrencyPresenter(model: model)
        let view = SelectCurrencyController(presenter: presenter)
        presenter.view = view
        return view
    }
}
