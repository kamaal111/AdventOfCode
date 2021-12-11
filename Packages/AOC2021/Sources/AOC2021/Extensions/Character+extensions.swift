//
//  Character+extensions.swift
//  
//
//  Created by Kamaal M Farah on 11/12/2021.
//

import Foundation

extension Character {
    var string: String {
        String(self)
    }

    var int: Int? {
        string.int
    }
}
