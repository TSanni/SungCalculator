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
            
            ScrollViewReader { proxy in
                ScrollView {
                    Text(highlightSymbols(in: calculator.textInput))
                        .foregroundStyle(.primary)
                        .font(.largeTitle)
                        .padding(.bottom, 30)
                        .id("bottom")
                }
                .onChange(of: calculator.textInput) { _ in
                    withAnimation {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
            
            Spacer()
            
            Text(calculator.runningTotal)
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
    
    
    private func highlightSymbols(in input: String) -> AttributedString {
        var attributed = AttributedString(input)

        for (i, char) in input.enumerated() {
            if char == "+" || char == "-" || char == "×" || char == "÷" || char == "%" {
                // Use String.Index to find range
                let nsRange = NSRange(location: i, length: 1)
                if let range = Range(nsRange, in: attributed) {
                    attributed[range].foregroundColor = .green
                }
            }
        }

        return attributed
    }
}

#Preview {
    CalculatorTopHalfView()
        .environmentObject(CalculatorViewModel.shared)

}
