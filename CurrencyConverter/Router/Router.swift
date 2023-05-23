//
//  Router.swift
//  CurrencyConverter
//
//  Created by APPLE on 22.05.2023.
//

import UIKit

protocol RouterMain {
    
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func selectedCurency(model: SelectCurrencyModel)
    func popToRoot()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let converterCurrencyVC = assemblyBuilder.createConverterCurrency(router: self)
        navigationController.viewControllers = [converterCurrencyVC]
    }
    
    func selectedCurency(model: SelectCurrencyModel) {
        let selectedCurencyVC = assemblyBuilder.createSelectedCurrency(router: self, model: model)
        navigationController.pushViewController(selectedCurencyVC, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
