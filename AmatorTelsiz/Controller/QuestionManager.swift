//
//  QuestionManager.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 28.04.2024.
//

import Foundation


import Foundation

class QuestionManager {
    static func readJSONFromFile(filename: String) -> Data? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error while reading data from file: \(error)")
                return nil
            }
        } else {
            print("File not found")
            return nil
        }
    }
}
