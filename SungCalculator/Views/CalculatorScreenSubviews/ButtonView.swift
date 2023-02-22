//
//  ButtonView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI



struct CircleButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(configuration.isPressed ? .title : .largeTitle)
            .font(.largeTitle)
            .overlay {
                Circle()
                    .fill(colorScheme == .dark ? .white.opacity(configuration.isPressed ? 0.5 : 0) : .gray.opacity(configuration.isPressed ? 0.5 : 0))
            }
    }
}

struct ButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var calculator: CalclutaorClass
    
    let screenWidth = UIScreen.main.bounds.width
    var buttonType: ButtonType
    var action: () -> Void
    let haptics = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        
        Button {
            self.haptics.notificationOccurred(.success)
            
            calculator.addInteger(num: buttonType.rawValue)
            calculator.checkSymbol(sym: buttonType)
            calculator.updateRunningResult()
            action()
            
        } label: {
            Text(buttonType.rawValue)
                .frame(width: screenWidth * 0.12, height: screenWidth * 0.12)
            //                    .frame(width: geo.size.width * 0.10, height: geo.size.height * 0.0)
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

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            //            Color.black
            ButtonView(buttonType: .equal) { }
                .environmentObject(CalclutaorClass())
        }
        
        ContentView()
    }
}
