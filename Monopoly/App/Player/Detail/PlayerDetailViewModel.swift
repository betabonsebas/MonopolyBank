//
//  PlayerDetailViewModel.swift
//  Monopoly
//
//  Created by Sebastian Bonilla Betancur on 9/2/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class PlayerDetailViewModel {
    var player: Player
    var reloadData:(() -> Void)?
    var showMessage:((String) -> Void)?
//    var sellPropertyFrom:((String, Property) -> Void)?
    var captureAmountForNewLoanWith: ((_ account: Player, _ completion: @escaping (String?) -> Void) -> Void)?
    var reloadUI: (() -> Void)?
    
    init(player: Player) {
        self.player = player
    }
    
    var name: String {
        return player.name
    }
    
    func addLoan() {
        captureAmountForNewLoanWith?(player, { [weak self] amount in
            guard let stringAmount = amount, let loanAmount = Int(stringAmount) else {
                return
            }
            self?.player.addLoan(loanAmount)
            self?.reloadUI?()
        })
    }
    
    func payLoan() {
        captureAmountForNewLoanWith?(player, { [weak self] amount in
            guard let stringAmount = amount, let feeAmount = Int(stringAmount) else {
                return
            }
            self?.player.payFee(feeAmount)
            self?.reloadUI?()
        })
    }
    
    func numberOfProperties() -> Int {
        return player.properties.count
    }
    
    func propertyAt(index: Int) -> Property {
        return player.properties[index]
    }
    
    func buyProperty(property: Property) {
        player.properties.append(property)
        self.reloadUI?()
    }
    
    func detailViewModelFor(index: Int) -> PropertyDetailViewModel {
        let property = propertyAt(index: index)
        return PropertyDetailViewModel(property: property)
    }
    
}
