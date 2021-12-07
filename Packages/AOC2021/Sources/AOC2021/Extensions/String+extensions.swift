//
//  String+extensions.swift
//  
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import Foundation

extension String {
    var splitLines: [String.SubSequence] {
        self.split(separator: "\n")
    }

    var splitCommas: [String.SubSequence] {
        self.split(separator: ",")
    }
}
