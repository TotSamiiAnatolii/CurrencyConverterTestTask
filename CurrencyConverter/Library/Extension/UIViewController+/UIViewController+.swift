//
//  UIViewController+.swift
//  CurrencyConverter
//
//  Created by APPLE on 25.05.2023.
//

import UIKit

extension UIViewController {
    
    func setupNavBar(header: String) {
        title = header
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : Fonts.baseFonts]
    }
}
