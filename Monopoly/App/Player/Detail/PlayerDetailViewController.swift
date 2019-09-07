//
//  PlayerDetailViewController.swift
//  Monopoly
//
//  Created by Sebastian Bonilla Betancur on 9/2/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    private struct Constants {
        static let propertyCellReuseIdentifier = "Property"
    }
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel: PlayerDetailViewModel! {
        didSet {
            viewModel.captureAmountForNewLoanWith = { [weak self] account, completion in
                self?.captureAmountForLoanWith(account: account, completion: completion)
            }
            
            viewModel.reloadUI = { [weak self] in
                self?.setupUI()
            }
            
            viewModel.reloadData = { [weak self] in
                self?.tableView.reloadData()
            }
            
            viewModel.showMessage = { [weak self] (message) in
                guard let alert = self?.warningAlert(message) else { return }
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func configureTableView() {
        self.title = viewModel.name
        let propertyCellNib = UINib(nibName: PropertyTableViewCell.nibName, bundle: nil)
        tableView.register(propertyCellNib, forCellReuseIdentifier: Constants.propertyCellReuseIdentifier)
    }
    
    private func setupUI() {
        playerNameLabel.text = "Valor Crédito"
        loanAmountLabel.text = "\(viewModel.player.totalLoansAmount())"
        tableView.reloadData()
    }
    
    @IBAction func addLoanAction(_ sender: Any) {
        viewModel.addLoan()
    }
    
    @IBAction func payFeeAction(_ sender: Any) {
        viewModel.payLoan()
    }
    
    @IBAction func buyPropertyAction(_ sender: Any) {
        let properties = PropertiesViewController(viewModel: PropertiesViewModel(properties: Game.shared.properties) ,delegate: self)
        self.present(properties, animated: true, completion: nil)
    }
    
    private func captureAmountForLoanWith(account: Player, completion: @escaping (_ playername: String?) -> Void) {
        let alert = newAmountAlert()
        alert.addTextField(configurationHandler: nil)
        alert.addAction(continueAlertAction(handler: { _ in
            completion(alert.textFields?[0].text)
        }))
        alert.addAction(cancelAlertAction(handler: { _ in
            completion(nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func newAmountAlert() -> UIAlertController {
        return UIAlertController(title: "", message: "Ingresa el valor.", preferredStyle: .alert)
    }
    
    private func continueAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Continuar", style: .default, handler: handler)
    }
    
    private func cancelAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Cancelar", style: .cancel, handler: handler)
    }
    
    private func aceptAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Continuar", style: .default, handler: handler)
    }
    
    private func warningAlert(_ message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Atención", message: message, preferredStyle: .alert)
        alert.addAction(aceptAlertAction(handler: { (_) in }))
        return alert
    }
    
}

extension PlayerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProperties()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.propertyCellReuseIdentifier, for: indexPath) as! PropertyTableViewCell
        cell.setup(with: viewModel.propertyAt(index: indexPath.row))
        return cell
    }
    
}

extension PlayerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = PropertyDetailViewController(viewModel: viewModel.detailViewModelFor(index: indexPath.row))
        guard let navigator = navigationController else {
            return
        }
        navigator.pushViewController(detail, animated: true)
    }
}

extension PlayerDetailViewController: SelectionPropertyDelegate {
    func selectedProperty(_ property: Property) {
        viewModel.buyProperty(property: property)
    }
}
