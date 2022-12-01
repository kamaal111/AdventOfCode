//
//  DayScreen.swift
//  AdventOfCode
//
//  Created by Kamaal M Farah on 01/12/2022.
//

import SwiftUI
import AOC2022
import SalmonUI

struct DayScreen: View {
    let day: AOC2022.Days

    init(day: AOC2022.Days) {
        self.day = day
    }

    init(_ day: AOC2022.Days) {
        self.init(day: day)
    }

    var body: some View {
        day.screen
    }
}

struct DayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DayScreen(day: .day1)
    }
}
