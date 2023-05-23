//
//  SelectCurrency.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

@IBDesignable
final class SelectCurrency: UIButton {
    
    private let placeholder = "Currency"
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }

    private func setPlaceholder() {
        setTitleColor(Colors.grayFontColor, for: .normal)
        setTitle(placeholder, for: .normal)
    }
    
    func setValue(code: String) {
        if code.isEmpty {
            setPlaceholder()
            return
        }
        setTitle(code, for: .normal)
        setTitleColor(.black, for: .normal)
    }
}
