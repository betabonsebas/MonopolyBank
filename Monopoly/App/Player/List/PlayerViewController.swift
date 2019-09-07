//
//  ViewController.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/18/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    private struct Constants {
        static let accountCellReuseIdentifier = "Account"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: PlayerViewModel! {
        didSet {
            viewModel.reloadAccounts = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlayerViewModel()
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
    
    
    
    private func newAccountAlert() -> UIAlertController {
        return UIAlertController(title: "Nuevo Jugador", message: "Ingresa el nombre del jugador dueño de la cuenta.", preferredStyle: .alert)
    }
    
    private func continueAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Continuar", style: .default, handler: handler)
    }
    
    private func cancelAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Cancelar", style: .cancel, handler: handler)
    }
    
    private func configureTableView() {
        let accountCellNib = UINib(nibName: PlayerViewCell.nibName, bundle: nil)
        tableView.register(accountCellNib, forCellReuseIdentifier: Constants.accountCellReuseIdentifier)
    }
}

extension PlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.accountCellReuseIdentifier, for: indexPath) as! PlayerViewCell
        cell.setup(with: viewModel.playerAt(index: indexPath.row))
        return cell
    }
}

extension PlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = UIStoryboard.init(name: "PlayerDetail", bundle: nil).instantiateInitialViewController() as! PlayerDetailViewController
        detail.viewModel = viewModel.detailViewModelFor(index: indexPath.row)
        splitViewController?.showDetailViewController(detail, sender: self)
    }
}


