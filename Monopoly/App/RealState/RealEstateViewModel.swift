//
//  RealEstateViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstateViewModel {
    private var realEstate: RealEstate
    private var sections: [RealEstateSection] = []
    
    var reloadData:(() -> Void)?
    var showMessage:((String) -> Void)?
    var sellPropertyFrom:((String, Property) -> Void)?
    
    init() {
        realEstate = RealEstate()
        registerForNotifications()
        buildData()
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfItemsAt(section: Int) -> Int {
        return sections[section].properties.count
    }
    
    func itemFor(section: Int, at position: Int) -> Property {
        return sections[section].properties[position]
    }
    
    func titleFor(section: Int) -> String {
        return sections[section].title
    }
    
    func addOwner(with name: String) {
        let owner = Player(name: name)
        realEstate.addOwner(owner)
        buildData()
    }
    
    func sellProperty(at section: Int, position: Int) {
        let owner = sections[section].title
        let property = sections[section].properties[position]
        sellPropertyFrom?(owner, property)
    }
    
    func sellProperty(_ property: Property, from: String, to: String) {
        do {
            try realEstate.buyProperty(property, ownerName: to)
            try realEstate.sellProperty(property.title, from: from)
        } catch let error {
            showMessage?(error.localizedDescription)
        }
        reloadData?()
    }
    
    func buildHouseForProperty(at section: Int, position: Int) {
        let property = self.itemFor(section: section, at: position)
        do {
            let price = try property.buildHouses(1)
            showMessage?("El valor de la casa es \(price)")
        }catch let error {
            showMessage?(error.localizedDescription)
        }
        reloadData?()
    }
    
    func buildHotelForProperty(at section: Int, position: Int) {
        let property = self.itemFor(section: section, at: position)
        do {
            let price = try property.buildHotels(1)
            showMessage?("El valor del hotel es \(price)")
        }catch let error {
            showMessage?(error.localizedDescription)
        }
        reloadData?()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createOwnerByAccountName(_:)),
                                               name: .bankCreateAccount,
                                               object: nil)
    }
    
    @objc private func createOwnerByAccountName(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let name = userInfo["name"] as? String else {
            return
        }
        addOwner(with: name)
    }
    
    private func buildData() {
        sections = []
        buildOwnerSections()
        reloadData?()
    }
    
    private func buildOwnerSections() {
        for section in 0..<realEstate.numberOfOwners {
            let owner = realEstate.ownerAt(section)
            sections.append(RealEstateSection(owner: owner))
        }
    }
}
