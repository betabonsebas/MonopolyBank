//
//  PropertyTableViewCell.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/23/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    var property: Property!
    
    static var nibName: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with property: Property) {
        self.property = property
        titleLabel.text = property.title
        subtitleLabel.text = buildingsString
    }
    
    private var buildingsString: String {
        return "🏠\t\(property.numberOfHouses)\t🏨\t\(property.numberOfHotels)"
    }
}
