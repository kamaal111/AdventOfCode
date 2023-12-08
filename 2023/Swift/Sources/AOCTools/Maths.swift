//
//  Maths.swift
//
//
//  Created by Kamaal M Farah on 08/12/2023.
//

import Foundation

public enum Maths {
    public static func quadraticEquation(_ a: Double, _ b: Double, _ c: Double) -> (shortest: Double, longest: Double) {
        let discriminant = sqrt((a * a) - 4.0 * b * c)
        let shortest = ceil((-a + discriminant) / -2.0)
        let longest = floor((-a - discriminant) / -2.0)
        return (shortest, longest)
    }
}
