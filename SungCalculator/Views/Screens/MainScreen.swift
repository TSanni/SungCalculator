//
//  MainScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/17/25.
//

import SwiftUI

struct MainScreen: View {
    @State private var textfieldText = "2+2+2+2+7"
    @State private var answer = "answer/running total"
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
    
    let buttonLayout: [ButtonType] = [
        .clear, .squared, .percent, .divide,
        .seven, .eight, .nine, .multiply,
        .four, .five, .six, .subtract,
        .one, .two, .three, .add,
        .negative, .zero, .decimal, .equal
    ]
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack(alignment: .trailing) {
                    TextField("Enter text", text: $textfieldText)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.primary)
                        .disabled(true)
                        .font(.largeTitle)
                        .padding(.bottom, 30)
                    
                    Spacer()
                    
                    TextField("Running total/answer", text: $answer)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.secondary)
                        .disabled(true)
                        .font(.title2)
                        .padding(.bottom, 30)
                    
                    HStack {
                        HStack(spacing: 50) {
                            Button {
                                
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
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(buttonLayout, id: \.self) { type in
                        ButtonView2(buttonType: type, geoProxy: geo)
                    }
                }
            }
        }
        .padding()
    }
}


struct ButtonView2: View {
    @Environment(\.colorScheme) var colorScheme
    var buttonType: ButtonType
    let haptics = UINotificationFeedbackGenerator()
    let geoProxy: GeometryProxy
    
    var body: some View {
        Button {
            self.haptics.notificationOccurred(.success)
        } label: {
            Text(buttonType.rawValue)
                .foregroundColor(buttonType.getForegroundColor)
                .frame(width: geoProxy.size.width * 0.12, height: geoProxy.size.width * 0.12)
                .padding()
                .background {
                    if buttonType == .equal {
                        Circle().fill(Color.green)
                    } else {
                        colorScheme == .light ? Circle().fill(.gray.opacity(0.1)) : Circle().fill(Color.goodBlack)
                    }
                }
        }
        .buttonStyle(CircleButton())
    }
}

#Preview {
    MainScreen()
}
