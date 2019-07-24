//
//  RealEstateViewModel.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class RealEstateViewModel {
    private var propertiesFactory: PropertiesFactory
    private var realEstate: RealEstate
    private var sections: [RealEstateSection] = []
    
    init() {
        propertiesFactory = PropertiesFactory(file: "Properties")
        realEstate = RealEstate()
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
    
    private func buildData() {
        sections = []
        buildOwnerSections()
        buildPropertiesSections()
    }
    
    private func buildOwnerSections() {
        for section in 0...realEstate.numberOfOwners {
            let owner = realEstate.ownerAt(section)
            sections.append(RealEstateSection(properties: owner.properties, title: owner.name))
        }
    }
    
    private func buildPropertiesSections() {
        sections.append(OneStataProperties)
        sections.append(TwoStataProperties)
        sections.append(ThreeStataProperties)
        sections.append(FourStataProperties)
        sections.append(TrainProperties)
        sections.append(UtilityProperties)
    }
    
    private var OneStataProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeOneStrataProperties(), title: "Estrato Uno")
    }
    private var TwoStataProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeTwoStrataProperties(), title: "Estrato Dos")
    }
    private var ThreeStataProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeThreeStrataProperties(), title: "Estrato Tres")
    }
    private var FourStataProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeFourStrataProperties(), title: "Estrato Cuatro")
    }
    private var UtilityProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeUtilitiesProperties(), title: "Servicios")
    }
    private var TrainProperties: RealEstateSection {
        return RealEstateSection(properties: propertiesFactory.makeTrainsProperties(), title: "Trenes")
    }
}
