//
//  DayScaffold.swift
//  
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import Foundation

protocol DayScaffold {
    static var resourceName: String { get }
}

extension DayScaffold {
    static var input: String {
        get {
            let inputURL = Bundle.module.url(forResource: resourceName, withExtension: "txt")!
            return try! String(contentsOf: inputURL, encoding: .utf8)
        }
    }
}
