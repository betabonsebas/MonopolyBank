//
//  RealEstateViewController.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

protocol SelectionPropertyDelegate: class {
    func selectedProperty(_ property: Property)
}

class PropertiesViewController: UIViewController {

    private struct Constants {
        static let propertyCellReuseIdentifier = "Property"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    weak var delegate: SelectionPropertyDelegate?
    
    convenience init(viewModel: PropertiesViewModel, delegate: SelectionPropertyDelegate) {
        self.init(nibName: "PropertiesViewController", bundle: nil)
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    var viewModel: PropertiesViewModel! {
        didSet {
//            viewModel.sellPropertyFrom = { [weak self] (owner, property) in
//                self?.exchange(property: property, from: owner)
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    private func exchange(property: Property, from: String) {
//        capturePlayerName { [weak self] (toOwner) in
//            self?.viewModel.sellProperty(property, from: from, to: toOwner ?? "")
//        }
//    }
    
    private func configureTableView() {
        let propertyCellNib = UINib(nibName: PropertyTableViewCell.nibName, bundle: nil)
        tableView.register(propertyCellNib, forCellReuseIdentifier: Constants.propertyCellReuseIdentifier)
    }
    
//    private func capturePlayerName(completion: @escaping (_ playername: String?) -> Void) {
//        let alert = newOwnerAlert()
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(continueAlertAction(handler: { _ in
//            completion(alert.textFields?[0].text)
//        }))
//        alert.addAction(cancelAlertAction(handler: { _ in
//            completion(nil)
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//
//    private func newOwnerAlert() -> UIAlertController {
//        return UIAlertController(title: "Nuevo Propietario", message: "Ingresa el nombre del comprador de la propiedad.", preferredStyle: .alert)
//    }
//
//    private func continueAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
//        return UIAlertAction(title: "Continuar", style: .default, handler: handler)
//    }
//
//    private func cancelAlertAction(handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
//        return UIAlertAction(title: "Cancelar", style: .cancel, handler: handler)
//    }
//


}

extension PropertiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProperties()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.propertyCellReuseIdentifier, for: indexPath) as! PropertyTableViewCell
        cell.setup(with: viewModel.itemAt(index: indexPath.row))
        return cell
    }
}

extension PropertiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedProperty(viewModel.itemAt(index: indexPath.row).copy())
        dismiss(animated: true, completion: nil)
    }
}
