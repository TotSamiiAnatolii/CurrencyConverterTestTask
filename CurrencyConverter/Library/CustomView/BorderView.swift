//
//  BorderView.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

enum StateBorderView {
    case beginEditing
    case endEditing
}

final class BorderView: UIView {

    func setColor(state: StateBorderView) {
        switch state {
        case .beginEditing:
            self.backgroundColor = Colors.editBorderColor
        case .endEditing:
            self.backgroundColor = Colors.borderColor
        }
    }
}
