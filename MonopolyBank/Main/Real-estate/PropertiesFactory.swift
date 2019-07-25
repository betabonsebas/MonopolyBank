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
    
    var properties: [Property] {
        var ps: [Property] = []
        ps.append(contentsOf: makeOneStrataProperties())
        ps.append(contentsOf: makeTwoStrataProperties())
        ps.append(contentsOf: makeThreeStrataProperties())
        ps.append(contentsOf: makeFourStrataProperties())
        ps.append(contentsOf: makeTrainsProperties())
        ps.append(contentsOf: makeUtilitiesProperties())
        return ps
    }
    
    private func makeOneStrataProperties() -> [OneStrata] {
        return data?.filter{ $0.color.contains("brown") || $0.color.contains("lightBlue") }.map{ OneStrata(data: $0) } ?? []
    }
    
    private func makeTwoStrataProperties() -> [TwoStrata] {
        return data?.filter{ $0.color.contains("pink") || $0.color.contains("orange") }.map{ TwoStrata(data: $0) } ?? []
    }
    
    private func makeThreeStrataProperties() -> [ThreeStrata] {
        return data?.filter{ $0.color.contains("red") || $0.color.contains("yellow") }.map{ ThreeStrata(data: $0) } ?? []
    }
    
    private func makeFourStrataProperties() -> [FourStrata] {
        return data?.filter{ $0.color.contains("green") || $0.color.contains("blue") }.map{ FourStrata(data: $0) } ?? []
    }
    
    private func makeUtilitiesProperties() -> [Utility] {
        return data?.filter{ $0.color.contains("white") }.map{ Utility(data: $0) } ?? []
    }
    
    private func makeTrainsProperties() -> [Train] {
        return data?.filter{ $0.color.contains("black") }.map{ Train(data: $0) } ?? []
    }
    
}
