//
//  DayScaffold.swift
//  
//
//  Created by Kamaal M Farah on 26/11/2022.
//

import Foundation

public protocol DayScaffold {
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
