//
//  StringProtocol+extensions.swift
//  
//
//  Created by Kamaal M Farah on 11/12/2021.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    var int: Int? {
        Int(self)
    }
}
