//
//  CalculatorScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/17/25.
//

import SwiftUI
import Expression

struct CalculatorScreen: View {
    @EnvironmentObject var calculator: CalculatorViewModel
    @EnvironmentObject var persistence: PersistenceController
    @State private var showToastAlert = false


    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                VStack {
                    CalculatorTopHalfView()
                    
                    Divider()
                        .padding(.vertical)
                    
                    CalculatorBottomHalfView(geo: geo)
                }
                
                if showToastAlert {
                    ToastAlert()
                        .offset(y: -40)
                        .zIndex(1)
                }
            }
            .onReceive(calculator.$showError) { show in
                if show {
                    showToastAlert = true
                    
                    // Automatically hide after 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showToastAlert = false
                            calculator.showError = false // Reset the flag
                        }
                    }
                }
            }
            .animation(.easeInOut, value: showToastAlert)
        }
        .padding()
    }
}


#Preview {
    CalculatorScreen()
        .environmentObject(CalculatorViewModel.shared)
        .environmentObject(PersistenceController.shared)
}
