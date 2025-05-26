//
//  CalculatorView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/29/22.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    @State private var showHistoryView = false
    
    var body: some View {
        VStack {
            TopView()
            Divider()
            BottomView()
        }
        .padding()
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .previewDevice("iPhone 11 Pro Max")
            .environmentObject(CalclutaorClass.shared)
        
    }
}
