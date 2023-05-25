//
//  ConverterCurrencyController.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

protocol ConverterCurrencyViewProtocol {
    func setFromValue(_ value: String)
    
    func setCalculatedValue(_ value: String)
    
    func noFromToСurrencySelected(_ fromButton: UIButton?, _ toButton: UIButton?)
  
    func setFromCurrencyCode(code: String)
    
    func setToCurrencyCode(code: String)
}

final class ConverterCurrencyController: UIViewController {

    @IBOutlet weak var fromValue: UITextField!
    
    @IBOutlet weak var toValue: UITextField!
    
    @IBOutlet weak var bottomConstraintRefresh: NSLayoutConstraint!
    
    @IBOutlet weak var fromCurrency: UILabel!
    
    @IBOutlet weak var toCurrency: UILabel!
    
    @IBOutlet weak var leftBorderView: BorderView!
        
    @IBOutlet weak var toSelectCurrencyButton: SelectCurrency!
    
    @IBOutlet weak var fromSelectCurrencyButton: SelectCurrency!
    
    var presenter: ConverterCurrencyPresenterProtocol

    private let header = "Currency converter"
    
    init(presenter: ConverterCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "ConverterCurrencyController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar(header: header)
        fromValue.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    //MARK: Action keyboard operation
    @objc func keyboardWillChange(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomConstraintRefresh.constant = keyboardHeight
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide() {
        bottomConstraintRefresh.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func swapСurrencies(_ sender: UIButton) {
        presenter.swapСurrencies()
    }
    
    @IBAction func fromSelectCurrecy(_ sender: SelectCurrency) {
        presenter.selectFromCurrency()
    }
    
    
    @IBAction func toSelectCurrecy(_ sender: SelectCurrency) {
        presenter.selectToCurrency()
    }

}
extension ConverterCurrencyController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        presenter.beginValueInput()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        leftBorderView.setColor(state: .beginEditing)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let decimalSeparator = Locale.current.decimalSeparator else { return false }
        
        if string == decimalSeparator {

            if textField.text?.contains(decimalSeparator) == true {
                return false
            }
            textField.insertText(decimalSeparator)
            return false
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let value = textField.text {
            presenter.setAmount(value)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        leftBorderView.setColor(state: .endEditing)
        presenter.setFromValue()
    }
}
extension ConverterCurrencyController: ConverterCurrencyViewProtocol {
    func setFromCurrencyCode(code: String) {
        fromCurrency.text = code
        fromCurrency.textColor = .black
    }
    
    func setToCurrencyCode(code: String) {
        toCurrency.text = code
        toCurrency.textColor = .black
    }
    
   
    func setCalculatedValue(_ value: String) {
        toValue.text = value
    }
    
    func setFromValue(_ value: String) {
        fromValue.text = value
    }
   
    func noFromToСurrencySelected(_ fromButton: UIButton?, _ toButton: UIButton?) {
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            fromButton?.layer.borderColor = Colors.errorColor.cgColor
            toButton?.layer.borderColor = Colors.errorColor.cgColor
        }) { _ in
            fromButton?.layer.borderColor = Colors.borderColor.cgColor
            toButton?.layer.borderColor = Colors.borderColor.cgColor
        }
    }
}
