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
                    ButtonView(buttonType: .clear) { }
                    Spacer()
                    ButtonView(buttonType: .squared) { }
                    Spacer()
                    ButtonView(buttonType: .percent) { }
                    Spacer()
                    ButtonView(buttonType: .divide) { }
                }
                HStack {
                    ButtonView(buttonType: .seven) { }
                    Spacer()
                    ButtonView(buttonType: .eight) { }
                    Spacer()
                    ButtonView(buttonType: .nine) { }
                    Spacer()
                    ButtonView(buttonType: .multiply) { }
                }
                HStack {
                    ButtonView(buttonType: .four) { }
                    Spacer()
                    ButtonView(buttonType: .five) { }
                    Spacer()
                    ButtonView(buttonType: .six) { }
                    Spacer()
                    ButtonView(buttonType: .subtract) { }
                }
                HStack {
                    ButtonView(buttonType: .one) { }
                    Spacer()
                    ButtonView(buttonType: .two) { }
                    Spacer()
                    ButtonView(buttonType: .three) { }
                    Spacer()
                    ButtonView(buttonType: .add) { }
                }
                HStack {
                    ButtonView(buttonType: .negative) { }
                    Spacer()
                    ButtonView(buttonType: .zero) { }
                    Spacer()
                    ButtonView(buttonType: .decimal) { }
                    Spacer()
                    ButtonView(buttonType: .equal) { }
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
