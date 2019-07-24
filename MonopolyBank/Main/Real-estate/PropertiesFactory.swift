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
    
    init(file: String) {
        self.data = FileReader.readData(fileName: file)
    }
    
    func makeOneStrataProperties() -> [OneStrata] {
        return data?.filter{ $0.color.contains("brown") || $0.color.contains("lightBlue") }.map{ OneStrata(data: $0) } ?? []
    }
    
    func makeTwoStrataProperties() -> [TwoStrata] {
        return data?.filter{ $0.color.contains("pink") || $0.color.contains("orange") }.map{ TwoStrata(data: $0) } ?? []
    }
    
    func makeThreeStrataProperties() -> [ThreeStrata] {
        return data?.filter{ $0.color.contains("red") || $0.color.contains("yellow") }.map{ ThreeStrata(data: $0) } ?? []
    }
    
    func makeFourStrataProperties() -> [FourStrata] {
        return data?.filter{ $0.color.contains("green") || $0.color.contains("blue") }.map{ FourStrata(data: $0) } ?? []
    }
    
    func makeUtilitiesProperties() -> [Utility] {
        return data?.filter{ $0.color.contains("white") }.map{ Utility(data: $0) } ?? []
    }
    
    func makeTrainsProperties() -> [Train] {
        return data?.filter{ $0.color.contains("black") }.map{ Train(data: $0) } ?? []
    }
    
}
