//
//  SelectCurrencyCell.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

final class SelectCurrencyCell: UITableViewCell {

    static let identifire = "SelectCurrencyCell"
    
    @IBOutlet weak var codeCurrency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.codeCurrency.text = nil
    }
    
}
extension SelectCurrencyCell: ConfigureView {
    func configure(with model: ModelSelectCurrencyCell) {
        self.codeCurrency.text = model.codeCurrency
    }
    
    typealias Model = ModelSelectCurrencyCell
}
