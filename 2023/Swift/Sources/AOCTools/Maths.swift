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

    public static func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        if b == 0 { a } else { greatestCommonDivisor(b, a % b) }
    }

    public static func leastCommonMultiple(_ a: Int, _ b: Int) -> Int {
        (a * b) / greatestCommonDivisor(a, b)
    }

    public static func leastCommonMultiple(_ values: [Int]) -> Int {
        guard values.count > 1 else { return values.first ?? 0 }
        return values.reduce(values[0], leastCommonMultiple)
    }
}
