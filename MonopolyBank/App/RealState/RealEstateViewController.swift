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
    var viewModel: RealEstateViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RealEstateViewModel()
        configureTableView()
    }
    
    private func configureTableView() {
        let propertyCellNib = UINib(nibName: PropertyTableViewCell.nibName, bundle: nil)
        tableView.register(propertyCellNib, forCellReuseIdentifier: Constants.propertyCellReuseIdentifier)
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
