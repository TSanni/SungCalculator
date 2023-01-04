//
//  ButtonView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

enum ButtonType: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    case clear = "C"
    case parenthesis = "()"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case subtract = "-"
    case add = "+"
    case decimal = "."
    case negative = "±"
    case equal = "="
    
    
    var getForegroundColor: Color? {
        switch self {
            case .clear:
                return .red
            case .parenthesis:
                return .green
            case .percent:
                return .green
            case .divide:
                return .green
            case .multiply:
                return .green
            case .subtract:
                return .green
            case .add:
                return .green
            default:
                return nil
        }
    }
    
    var getBackgroundColor: Color? {
        switch self {
            case .equal:
                return Color.green
            default:
                return nil
        }
    }

}

struct CircleButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(configuration.isPressed ? .title : .largeTitle)
            .font(.largeTitle)
//            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
            .overlay {
                Circle()
                    .fill(colorScheme == .dark ? .white.opacity(configuration.isPressed ? 0.5 : 0) : .gray.opacity(configuration.isPressed ? 0.5 : 0))
//                    .fill(.white.opacity(configuration.isPressed ? 0.5 : 0))
//                    .scaleEffect(configuration.isPressed ? 0.7 : 1.0)

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
                print("Can add decimal: \(calculator.possibleToAddDecimal)")
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
