//
//  MainScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/17/25.
//

import SwiftUI
import Expression

struct MainScreen: View {
    @EnvironmentObject var calculator: Calculator
    @EnvironmentObject var persistence: PersistenceController
    @State private var showToastAlert = false
    @Environment(\.colorScheme) var colorScheme

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
    
    private let buttonLayout: [ButtonType] = [
        .clear, .squared, .percent, .divide,
        .seven, .eight, .nine, .multiply,
        .four, .five, .six, .subtract,
        .one, .two, .three, .add,
        .negative, .zero, .decimal, .equal
    ]
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                VStack {
                    VStack(alignment: .trailing) {
                        TextField("Enter text", text: $calculator.textInput)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.primary)
                            .disabled(true)
                            .font(.largeTitle)
                            .padding(.bottom, 30)
                        
                        Spacer()
                        
                        TextField("Running total/answer", text: $calculator.runningTotal)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.secondary)
                            .disabled(true)
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
                    
                    Divider()
                        .padding(.vertical)
                    
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

struct ToastAlert: View {
    var body: some View {
        Text("Invalid format used.")
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.gray)
                    .opacity(0.5)
            }
    }
}

#Preview {
    MainScreen()
        .environmentObject(Calculator.shared)
        .environmentObject(PersistenceController.shared)
}
