//
//  AOC2022.swift
//
//
//  Created by Kamaal M Farah on 26/11/2022.
//

import SwiftUI
import SalmonUI

public struct AOC2022 {
    private init() { }

    public enum Days: String, CaseIterable {
        case day1 = "Day 1"

        public var title: String {
            rawValue
        }

        public var screen: some View {
            KJustStack {
                switch self {
                case .day1:
                    Day1.Screen()
                }
            }
        }
    }
}
