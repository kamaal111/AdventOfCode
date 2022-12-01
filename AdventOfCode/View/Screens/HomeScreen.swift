//
//  HomeScreen.swift
//  AdventOfCode
//
//  Created by Kamaal M Farah on 01/12/2022.
//

import SwiftUI
import AOC2022
import SalmonUI

struct HomeScreen: View {
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("2022")
                .font(.title2)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(AOC2022.Days.allCases, id: \.self) { day in
                    NavigationLink(value: day) {
                        Text(day.title)
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                            .ktakeWidthEagerly()
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .ktakeSizeEagerly(alignment: .top)
        .navigationDestination(for: AOC2022.Days.self, destination: DayScreen.init(_:))
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
