//
//  CalculatorTopHalfView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/26/25.
//

import SwiftUI

struct CalculatorTopHalfView: View {
    @EnvironmentObject var calculator: CalculatorViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            HStack(spacing: 0) {
                ForEach(Array(calculator.textInput), id: \.self) { char in
                    Text(String(char))
                        .foregroundStyle(char == "+" || char == "-" || char == "×" || char == "÷" || char == "%" ? Color.green : .primary)
                }
            }
            .foregroundStyle(.primary)
            .font(.largeTitle)
            .padding(.bottom, 30)
            
            Spacer()
            
            TextField("", text: $calculator.runningTotal)
                .disabled(true)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.secondary)
                .font(.title2)
                .padding(.bottom, 30)
            
            HStack {
                HStack(spacing: 50) {
                    Button {
                        withAnimation {
                            calculator.toggleHistoryView()
                        }
                    } label: {
                        Image(systemName: "clock")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ruler")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "x.squareroot")
                    }
                }
                
                Spacer()
                
                Button {
                    calculator.handleButtonPressed(buttonType: .deleteButton)
                } label: {
                    Image(systemName: "delete.backward")
                }
                .tint(.green)
            }
            .tint(.secondary)
            .font(.title2)
        }
    }
}

#Preview {
    CalculatorTopHalfView()
        .environmentObject(CalculatorViewModel.shared)

}
