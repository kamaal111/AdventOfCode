//
//  String+extensions.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2022.
//

import Foundation

extension String {
    func range(from start: Int, to end: Int? = nil) -> Substring {
        self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end ?? count)]
    }
}
