//
//  BottomView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct BottomView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    let screenSize = UIScreen.main.bounds
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                HStack {
                    OldButtonView(buttonType: .clear) { }
                    Spacer()
                    OldButtonView(buttonType: .squared) { }
                    Spacer()
                    OldButtonView(buttonType: .percent) { }
                    Spacer()
                    OldButtonView(buttonType: .divide) { }
                }
                HStack {
                    OldButtonView(buttonType: .seven) { }
                    Spacer()
                    OldButtonView(buttonType: .eight) { }
                    Spacer()
                    OldButtonView(buttonType: .nine) { }
                    Spacer()
                    OldButtonView(buttonType: .multiply) { }
                }
                HStack {
                    OldButtonView(buttonType: .four) { }
                    Spacer()
                    OldButtonView(buttonType: .five) { }
                    Spacer()
                    OldButtonView(buttonType: .six) { }
                    Spacer()
                    OldButtonView(buttonType: .subtract) { }
                }
                HStack {
                    OldButtonView(buttonType: .one) { }
                    Spacer()
                    OldButtonView(buttonType: .two) { }
                    Spacer()
                    OldButtonView(buttonType: .three) { }
                    Spacer()
                    OldButtonView(buttonType: .add) { }
                }
                HStack {
                    OldButtonView(buttonType: .negative) { }
                    Spacer()
                    OldButtonView(buttonType: .zero) { }
                    Spacer()
                    OldButtonView(buttonType: .decimal) { }
                    Spacer()
                    OldButtonView(buttonType: .equal) { }
                }
            }
            .padding(.top)
            .zIndex(0)

            if calculator.showHistoryView {
                HistoryView()
                    .frame(width: screenSize.width * 0.70)
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

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
            .previewDevice("iPhone 11 Pro Max")
            .environmentObject(CalclutaorClass.shared)
    }
}
