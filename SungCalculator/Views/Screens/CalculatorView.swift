//
//  CalculatorView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/29/22.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    
    var body: some View {
        VStack {
            TopScreenView()
            Divider()
            BottomView()
        }
        .padding()
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(CalclutaorClass())

    }
}
