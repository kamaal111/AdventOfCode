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

    func map<T>(_ transform: (Element) -> T, untill predicate: (T) -> Bool) -> [T] {
        var array: [T] = []
        for element in self {
            let transformedElement = transform(element)
            array.append(transformedElement)
            if predicate(transformedElement) {
                return array
            }
        }

        return array
    }

    func removedLast() -> [Element] {
        var array = self
        _ = array.popLast()
        return array
    }
}
