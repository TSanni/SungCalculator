//
//  CalculatorBottomHalfView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/26/25.
//

import SwiftUI

struct CalculatorBottomHalfView: View {
    @EnvironmentObject var calculator: CalculatorViewModel
    @Environment(\.colorScheme) var colorScheme
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
    let geo: GeometryProxy

    private let buttonLayout: [ButtonType] = [
        .clear, .squared, .percent, .divide,
        .seven, .eight, .nine, .multiply,
        .four, .five, .six, .subtract,
        .one, .two, .three, .add,
        .negative, .zero, .decimal, .equal
    ]
    var body: some View {
        ZStack(alignment: .leading) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(buttonLayout, id: \.self) { type in
                    ButtonView(buttonType: type, geoProxy: geo)
                }
            }
            
            if calculator.showHistoryView {
                HistoryView()
                    .frame(width: geo.size.width * 0.8)
                    .frame(maxHeight: .infinity)
                    .background {
                        colorScheme == .dark ? Color.black : Color.white
                    }
                    .transition(AnyTransition.move(edge: .leading))
                    .zIndex(1)
            }

        }
    }
}

#Preview {
    GeometryReader { geo in
        CalculatorBottomHalfView(geo: geo)
            .environmentObject(CalculatorViewModel.shared)

    }
}
