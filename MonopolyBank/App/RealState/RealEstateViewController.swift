//
//  RealEstateViewController.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class RealEstateViewController: UIViewController {

    private struct Constants {
        static let propertyCellReuseIdentifier = "Property"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: RealEstateViewModel! {
        didSet {
            viewModel.reloadData = { [weak self] in
                self?.tableView.reloadData()
            }
            
            viewModel.showMessage = { [weak self] (message) in
                guard let alert = self?.warningAlert(message) else { return }
                self?.present(alert, animated: true, completion: nil)
            }
            
            viewModel.sellPropertyFrom = { [weak self] (owner, property) in
                self?.exchange(property: property, from: owner)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RealEstateViewModel()
        configureTableView()
    }
    
    private func exchange(property: Property, from: String) {
        capturePlayerName { [weak self] (toOwner) in
            self?.viewModel.sellProperty(property, from: from, to: toOwner ?? "")
        }
    }
    
    private func configureTableView() {
        let propertyCellNib = UINib(nibName: PropertyTableViewCell.nibName, bundle: nil)
        tableView.register(propertyCellNib, forCellReuseIdentifier: Constants.propertyCellReuseIdentifier)
    }
    
    private func capturePlayerName(completion: @escaping (_ playername: String?) -> Void) {
        let alert = newOwnerAlert()
        alert.addTextField(configurationHandler: nil)
        alert.addAction(continueAlertAction(handler: { _ in
            completion(alert.textFields?[0].text)
        }))
        alert.addAction(cancelAlertAction(handler: { _ in
            completion(nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func newOwnerAlert() -> UIAlertController {
        return UIAlertController(title: "Nuevo Propietario", message: "Ingresa el nombre del comprador de la propiedad.", preferredStyle: .alert)
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

extension RealEstateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.propertyCellReuseIdentifier, for: indexPath) as! PropertyTableViewCell
        cell.setup(with: viewModel.itemFor(section: indexPath.section, at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleFor(section: section)
    }
}

extension RealEstateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        actions.append(buyHotelAction(with: indexPath))
        actions.append(buyHouseAction(with: indexPath))
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        actions.append(sellAction(with: indexPath))
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    private func buyHouseAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Casa") { [weak self] action, view, handler in
            self?.viewModel.buildHouseForProperty(at: indexPath.section, position: indexPath.row)
            handler(true)
        }
        
        action.image = UIImage(named: "house")
        action.backgroundColor = UIColor.orange
        return action
    }
    
    private func buyHotelAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Hotel") { [weak self] action, view, handler in
            self?.viewModel.buildHotelForProperty(at: indexPath.section, position: indexPath.row)
            handler(true)
        }
        
        action.image = UIImage(named: "hotel-star")
        action.backgroundColor = UIColor.green
        return action
    }
    
    private func sellAction(with indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Vender") { [weak self] action, view, handler in
            self?.viewModel.sellProperty(at: indexPath.section, position: indexPath.row)
            handler(true)
        }
        
        action.image = UIImage(named: "landlord")
        action.backgroundColor = UIColor.green
        return action
    }
}
