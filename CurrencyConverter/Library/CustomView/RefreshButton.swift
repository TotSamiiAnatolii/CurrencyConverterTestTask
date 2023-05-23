//
//  RefreshButton.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

@IBDesignable
final class RefreshButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        self.layer.cornerRadius = cornerRadius
    }
}
