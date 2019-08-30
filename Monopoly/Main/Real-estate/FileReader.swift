//
//  FileReader.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

class FileReader {
    static func readData<T: Codable>(fileName: String) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            let codable = try decoder.decode(T.self, from: data)
            return codable
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
