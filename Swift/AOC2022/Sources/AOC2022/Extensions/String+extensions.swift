//
//  String+extensions.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2022.
//

import Foundation

extension StringProtocol {
    func range(from start: Int, to end: Int? = nil) -> Self.SubSequence {
        self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end ?? count)]
    }
}
