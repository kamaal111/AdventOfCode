//
//  String+extensions.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
