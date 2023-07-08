//
//  SelectCurrency.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

@IBDesignable
final class SelectCurrency: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    override var isHighlighted: Bool {
        
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }
    
    private func updateView() {
        self.layer.borderWidth = AppDesign.borderWidth
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    private func touchUp() {
        UIView.animateKeyframes(withDuration: AppDesign.withDuration,
                                delay: .zero,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.layer.borderColor = Colors.borderColor.cgColor
        })
    }
    
    private func touchDown() {
        self.layer.borderColor = Colors.selectBorederColor.cgColor
    }
}
