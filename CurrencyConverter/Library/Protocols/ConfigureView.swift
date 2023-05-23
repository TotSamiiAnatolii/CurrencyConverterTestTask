//
//  ConfigureView.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import Foundation

protocol ConfigureView {
    associatedtype Model
    
    func configure(with model: Model)
}
