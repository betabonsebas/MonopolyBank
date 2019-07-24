//
//  AccountTableViewCell.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak private var playerNameLabel: UILabel!
    @IBOutlet weak private var loanAmountLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with account: Account) {
        playerNameLabel.text = account.playerName
        loanAmountLabel.text = "\(account.totalLoansAmount())"
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}
