//
//  RealStateFactory.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/22/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class PropertiesFactory {
    private var data: [PropertyData]?
    
    init() {
        self.data = FileReader.readData(fileName: "Properties")
    }
    
    var properties: [Property] {
        var ps: [Property] = []
        ps.append(contentsOf: makeStrataProperties())
        ps.append(contentsOf: makeNoStrataProperties())
        
        return ps
    }
    
    private func makeStrataProperties() -> [StrataProperty] {
        return data?.filter{ $0.buildingPrice > 0 }.map{ StrataProperty(data: $0) } ?? []
    }
    
    private func makeNoStrataProperties() -> [NoStrataProperty] {
        return data?.filter{ $0.buildingPrice == 0 }.map{ NoStrataProperty(data: $0) } ?? []
    }
}
