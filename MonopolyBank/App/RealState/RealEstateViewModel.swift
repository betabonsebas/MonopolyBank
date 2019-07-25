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
        let owner = Owner(name: name)
        realEstate.addOwner(owner)
        buildData()
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
