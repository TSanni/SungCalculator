//
//  ButtonView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/26/25.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var calculator: CalculatorViewModel
    @Environment(\.colorScheme) var colorScheme
    var buttonType: ButtonType
    let haptics = UINotificationFeedbackGenerator()
    let geoProxy: GeometryProxy
    
    var body: some View {
        Button {
            self.haptics.notificationOccurred(.success)
            calculator.handleButtonPressed(buttonType: buttonType)
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


#Preview {
    GeometryReader { geo in
        ButtonView(buttonType: .add, geoProxy: geo)

    }
}
