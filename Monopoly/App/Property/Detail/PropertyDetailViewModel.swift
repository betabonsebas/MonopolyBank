//
//  PropertyDetailViewModel.swift
//  Monopoly
//
//  Created by Sebastian Bonilla Betancur on 9/4/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class PropertyDetailViewModel {
    var property: Property!
    var showMessage:((String) -> Void)?
    var reloadData:(() -> Void)?
    
    init(property: Property) {
        self.property = property
    }
    
    var numberOfHouses: Int {
        return property.numberOfHouses
    }
    
    var numberOfHotel: Int {
        return property.hasHotel ? 1 : 0
    }
    
    func buildHouse(_ number: Int) {
        do {
            try property.setHouses(number)
            showMessage?("El valor de la casa es \(property.data.buildingPrice * number)")
        }catch let error {
            showMessage?(error.localizedDescription)
        }
        reloadData?()
    }
    
    func buildHotel() {
        do {
            try property.setHotel()
            showMessage?("El valor del hotel es \(property.data.buildingPrice) + 4 Casas")
        }catch let error {
            showMessage?(error.localizedDescription)
        }
        reloadData?()
    }
}
