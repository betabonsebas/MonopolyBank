//
//  DetailViewController.swift
//  Monopoly
//
//  Created by Sebastian Bonilla Betancur on 9/4/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class PropertyDetailViewController: UIViewController {

    private var viewModel: PropertyDetailViewModel! {
        didSet {
            viewModel.showMessage = { [weak self] (message) in
                guard let alert = self?.warningAlert(message) else { return }
                self?.present(alert, animated: true, completion: nil)
            }
            
            viewModel.reloadData = { [weak self] in
                self?.setupUI()
            }
        }
    }
    @IBOutlet weak var housesLabel: UILabel!
    @IBOutlet weak var hotelLabel: UILabel!
    
    convenience init(viewModel: PropertyDetailViewModel) {
        self.init(nibName: "PropertyDetailViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.property.title
        setupUI()
    }
    
    @IBAction func housesStepperAction(_ sender: UIStepper) {
        let number = Int(sender.value)
        viewModel.buildHouse(number)
    }
    
    @IBAction func hotelStepperAction(_ sender: UIStepper) {
        viewModel.buildHotel()
    }
    
    @IBAction func sellPropertyAction(_ sender: Any) {
//        let properties = PropertiesViewController(viewModel: PropertiesViewModel(properties: viewModel.player.properties) ,delegate: self)
//        self.present(properties, animated: true, completion: nil)
    }
    
    private func setupUI() {
        housesLabel.text = "\(viewModel.numberOfHouses)"
        hotelLabel.text = "\(viewModel.numberOfHotel)"
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
extension PropertyDetailViewController {
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        var actions: [UIContextualAction] = []
//        actions.append(buyHotelAction(with: indexPath))
//        actions.append(buyHouseAction(with: indexPath))
//        return UISwipeActionsConfiguration(actions: actions)
//    }
//    
//    private func buyHouseAction(with indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .normal, title: "Casa") { [weak self] action, view, handler in
//            self?.viewModel.buildHouseForProperty(at: indexPath.row)
//            handler(true)
//        }
//        
//        action.image = UIImage(named: "house")
//        action.backgroundColor = UIColor.orange
//        return action
//    }
//    
//    private func buyHotelAction(with indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .normal, title: "Hotel") { [weak self] action, view, handler in
//            self?.viewModel.buildHotelForProperty(at: indexPath.row)
//            handler(true)
//        }
//        
//        action.image = UIImage(named: "hotel-star")
//        action.backgroundColor = UIColor.green
//        return action
//    }
}
