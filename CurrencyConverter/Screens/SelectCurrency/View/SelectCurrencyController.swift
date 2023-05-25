//
//  SelectCurrencyController.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

protocol SelectCurrencyViewProtocol: AnyObject {
    
}

final class SelectCurrencyController: UIViewController {
    
    private let header = "Select currency"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: SelectCurrencyPresenterProtocol
    
    private var lastSelectedIndexPath: IndexPath = [0, 0]
    
    init(presenter: SelectCurrencyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SelectCurrencyController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar(header: header)
        prepareTableView()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SelectCurrencyCell.identifire, bundle: nil), forCellReuseIdentifier: SelectCurrencyCell.identifire)
        tableView.tableHeaderView = UIView()
    }
}
extension SelectCurrencyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.listCurrencyCell.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCurrencyCell.identifire, for: indexPath) as? SelectCurrencyCell else {
            return UITableViewCell()
        }
        if presenter.listCurrencyCell[indexPath.row].codeCurrency == presenter.model.isCurrency {
            lastSelectedIndexPath = indexPath
            cell.accessoryType = .checkmark
        }
        cell.configure(with: presenter.listCurrencyCell[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.setCurrency(currency: presenter.listCurrencyCell[indexPath.row].codeCurrency)
        
        self.tableView.cellForRow(at: lastSelectedIndexPath)?.accessoryType = .none
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        lastSelectedIndexPath = indexPath
    }
}
extension SelectCurrencyController: SelectCurrencyViewProtocol {
    
}
