//
//  ViewController.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class BankViewController: UIViewController {

    private struct Constants {
        static let accountCellReuseIdentifier = "Account"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: BankViewModel! {
        didSet {
            viewModel.reloadAccounts = { [weak self] in
                self?.tableView.reloadData()
            }
            
            viewModel.captureAmountForNewLoanWith = { account, completion in
                self.captureAmountForLoanWith(account: account, completion: completion)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BankViewModel()
        self.configureTableView()
    }
    
    @IBAction func addAccountAction(_ sender: Any) {
        capturePlayerName { [weak self] name in
            self?.viewModel.addAccountFor(name)
        }
    }
    
    private func capturePlayerName(completion: @escaping (_ playername: String?) -> Void) {
        let alert = newAccountAlert()
        alert.addTextField(configurationHandler: nil)
        alert.addAction(continueAlertAction(handler: { _ in
            completion(alert.textFields?[0].text)
        }))
        alert.addAction(cancelAlertAction(handler: { _ in
            completion(nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func captureAmountForLoanWith(account: Account, completion: @escaping (_ playername: String?) -> Void) {
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
    
    private func newAccountAlert() -> UIAlertController {
        return UIAlertController(title: "Nuevo Jugador", message: "Ingresa el nombre del jugador dueño de la cuenta.", preferredStyle: .alert)
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
    
    private func configureTableView() {
        let accountCellNib = UINib(nibName: AccountTableViewCell.nibName, bundle: nil)
        tableView.register(accountCellNib, forCellReuseIdentifier: Constants.accountCellReuseIdentifier)
    }
}

extension BankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAccounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.accountCellReuseIdentifier, for: indexPath) as! AccountTableViewCell
        cell.setup(with: viewModel.accountAt(index: indexPath.row))
        return cell
    }
}

extension BankViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        actions.append(payRowAction(with: indexPath))
        actions.append(newLoanContextualAction(with: indexPath))
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        actions.append(bankruptcyRowAction(with: indexPath))
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    private func newLoanContextualAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Prestamo") { [weak self] action, view, handler in
            self?.viewModel.loanForAccount(at: indexPath.row)
            handler(true)
        }
        
        action.image = UIImage(named: "debt")
        action.backgroundColor = UIColor.orange
        return action
    }
    
    private func payRowAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Pagar") { [weak self] action, view, handler in
            self?.viewModel.payLoanForAccount(at: indexPath.row)
            handler(true)
        }
        
        action.image = UIImage(named: "card-payment")
        action.backgroundColor = UIColor.green
        return action
    }
    
    private func bankruptcyRowAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Bancarrota") { [weak self] action, view, handler in
            
            handler(true)
        }
        
        action.image = UIImage(named: "delete-bin")
        action.backgroundColor = UIColor.red
        return action
    }
}


