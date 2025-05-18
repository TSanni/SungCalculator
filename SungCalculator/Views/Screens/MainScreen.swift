//
//  MainScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/17/25.
//

import SwiftUI

struct MainScreen: View {
    @StateObject var calculator = CalclutaorClass.shared
    @State private var textfieldText = "2+2+2+2+7"
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                TextField("Enter text", text: $calculator.textInput)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.primary)
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                
                Text("Running total/answer")
                    .foregroundStyle(.secondary)
                    .font(.title2)
                    .padding(.bottom, 50)
                
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
                .font(.title)
            }
            
            Divider()
            
            VStack {
                HStack {
                    ButtonView2(buttonType: .clear)
                    Spacer()
                    ButtonView2(buttonType: .squared)
                    Spacer()
                    ButtonView2(buttonType: .percent)
                    Spacer()
                    ButtonView2(buttonType: .divide)
                }
                
                HStack {
                    ButtonView2(buttonType: .seven)
                    Spacer()
                    ButtonView2(buttonType: .eight)
                    Spacer()
                    ButtonView2(buttonType: .nine)
                    Spacer()
                    ButtonView2(buttonType: .multiply)
                }
                
                HStack {
                    ButtonView2(buttonType: .four)
                    Spacer()
                    ButtonView2(buttonType: .five)
                    Spacer()
                    ButtonView2(buttonType: .six)
                    Spacer()
                    ButtonView2(buttonType: .subtract)
                }
                
                HStack {
                    ButtonView2(buttonType: .one)
                    Spacer()
                    ButtonView2(buttonType: .two)
                    Spacer()
                    ButtonView2(buttonType: .three)
                    Spacer()
                    ButtonView2(buttonType: .add)
                }
                
                HStack {
                    ButtonView2(buttonType: .negative)
                    Spacer()
                    ButtonView2(buttonType: .zero)
                    Spacer()
                    ButtonView2(buttonType: .decimal)
                    Spacer()
                    ButtonView2(buttonType: .equal)
                }
            }
            .environmentObject(calculator)
        }
        .padding()
    }
}


struct ButtonView2: View {
    @Environment(\.colorScheme) var colorScheme
    let screenWidth = UIScreen.main.bounds.width
    var buttonType: ButtonType
    let haptics = UINotificationFeedbackGenerator()
    @EnvironmentObject var calculator: CalclutaorClass

    var body: some View {
        
        Button {
            self.haptics.notificationOccurred(.success)
            calculator.textInput.append(buttonType.rawValue)
        } label: {
            Text(buttonType.rawValue)
                .frame(width: screenWidth * 0.12, height: screenWidth * 0.12)
                .padding()
                .foregroundColor(buttonType.getForegroundColor)
                .clipShape(Circle())
                .background{
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
