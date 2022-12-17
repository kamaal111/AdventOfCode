//
//  Array+extensions.swift
//  
//
//  Created by Kamaal Farah on 08/12/2022.
//

import Foundation

extension Array {
    func range(from start: Int, to end: Int? = nil) -> ArraySlice<Element> {
        var end = end ?? count
        if end > count {
            end = count
        }

        return self[start..<end]
    }

    func removedLast() -> [Element] {
        var array = self
        array.removeLast()
        return array
    }
}
