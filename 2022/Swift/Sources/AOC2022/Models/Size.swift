//
//  Size.swift
//  
//
//  Created by Kamaal M Farah on 10/12/2022.
//

import Foundation

public struct Size: Equatable {
    public var width: Int
    public var height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public static let zero = Size(width: 0, height: 0)
}
