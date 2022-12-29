//
//  BottomView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct BottomView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    
    var body: some View {
        VStack {
            HStack {
                ButtonView(buttonType: .clear) { calculator.clearAll() }
                Spacer()
                ButtonView(buttonType: .parenthesis) { }
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
                ButtonView(buttonType: .equal) { calculator.getResult()}
            }
        }
        .padding(.top)
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
            .environmentObject(CalclutaorClass())
    }
}
