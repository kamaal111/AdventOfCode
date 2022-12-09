//
//  String+extensions.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation

extension StringProtocol {
    var int: Int? {
        Int(self)
    }

    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
