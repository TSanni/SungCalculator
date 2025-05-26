//
//  MainScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/17/25.
//

import SwiftUI
import Expression

class Calculator: ObservableObject {
    @Published var textInput = ""
    @Published var runningTotal = ""
    @Published var showError = false
    var arrayOfButtonTypes: [ButtonType] = []
//    var lastButtonInputIsInt = false
    
    static let shared = Calculator()
    
    private init() { }
    
    private func handleDeleteButtonPressed() {
        print(#function)
        if textInput.isEmpty { return }
        
        textInput.removeLast()
        arrayOfButtonTypes.removeLast()
        
//        guard let lastInput = arrayOfButtonTypes.last else {
//            print("Empty array")
//            return
//        }
        
//        if lastInput.isInt {
//            lastButtonInputIsInt = true
//        } else {
//            lastButtonInputIsInt = false
//        }
    }
    
    private func handleClearButtonPressed() {
        print(#function)
        textInput.removeAll()
        runningTotal.removeAll()
        arrayOfButtonTypes.removeAll()
//        lastButtonInputIsInt = false
    }
    
    private func handleOperationButtonPressed(buttonType: ButtonType) {
        if textInput.isEmpty { return }

        guard let lastCharacter = arrayOfButtonTypes.last else { return }
        
        if lastCharacter.isOperation {
            textInput.removeLast()
            arrayOfButtonTypes.removeLast()
            
            textInput.append(buttonType.rawValue)
            arrayOfButtonTypes.append(buttonType)
        } else {
            textInput.append(buttonType.rawValue)
            arrayOfButtonTypes.append(buttonType)
        }
        
//        lastButtonInputIsInt = false
    }
    
    // TODO: - Add more cases
    private func handleDecimalButtonPressed(buttonType: ButtonType) {
        // Ex) ""
        if textInput.isEmpty && arrayOfButtonTypes.isEmpty {
            textInput.append("0.")
            arrayOfButtonTypes.append(.zero)
            arrayOfButtonTypes.append(.decimal)
//            lastButtonInputIsInt = false
        }
        
        // Ex) 2.
        if textInput.last == "." && arrayOfButtonTypes.last == .decimal {
            return
        }
        
        // Ex) 2.5
        
        
        
        textInput.append(".")
        arrayOfButtonTypes.append(.decimal)
        
    }
    
    private func handleIntButtonPressed(buttonType: ButtonType) {
        
        let lastInput = arrayOfButtonTypes.last
        
        if lastInput == .zero && buttonType == .zero && arrayOfButtonTypes.count <= 1{
            return
        }
        
        textInput.append(buttonType.rawValue)
        arrayOfButtonTypes.append(buttonType)
//        lastButtonInputIsInt = true
    }
    
    private func handlePercentButtonPressed(buttonType: ButtonType) {
        
    }
    
    private func handleSquaredButtonPressed(buttonType: ButtonType) {
        
    }
    
    private func handleNegativeButtonPressed(buttonType: ButtonType) {
        
    }
    
    private func handleEqualsButtonPressed(buttonType: ButtonType) {
        let expression = Expression(textInput)
        do {
            let result = try expression.evaluate()
            textInput = result.description
        } catch  {
           // let errorMessage = "Invalid format used"
            showError = true
        }
    }
    
    private func updateRunningTotal() {
        let textInputCompatibleWithExpression = textInput
            .replacingOccurrences(of: ButtonType.multiply.rawValue, with: "*")
            .replacingOccurrences(of: ButtonType.divide.rawValue, with: "/")
        
        let expression = Expression(textInputCompatibleWithExpression)
        do {
            let result = try expression.evaluate()
            runningTotal = result.description
        } catch {
            let errorMessage = ""
            runningTotal = errorMessage
        }
    }
    
    func handleButtonPressed(buttonType: ButtonType) {
        switch buttonType {
        case .clear:
            handleClearButtonPressed()
        case .squared:
            handleSquaredButtonPressed(buttonType: buttonType)
        case .percent:
            handlePercentButtonPressed(buttonType: buttonType)
        case .divide:
            handleOperationButtonPressed(buttonType: buttonType)
        case .multiply:
            handleOperationButtonPressed(buttonType: buttonType)
        case .subtract:
            handleOperationButtonPressed(buttonType: buttonType)
        case .add:
            handleOperationButtonPressed(buttonType: buttonType)
        case .decimal:
            handleDecimalButtonPressed(buttonType: buttonType)
        case .negative:
            handleNegativeButtonPressed(buttonType: buttonType)
        case .equal:
            handleEqualsButtonPressed(buttonType: buttonType)
//        case .historyButton:
//            <#code#>
//        case .rulerButton:
//            <#code#>
//        case .squareRootButton:
//            <#code#>
        case .deleteButton:
            handleDeleteButtonPressed()
            
        default:
            handleIntButtonPressed(buttonType: buttonType)
        }
        
        updateRunningTotal()
    }
}

struct MainScreen: View {
    @StateObject var calculator: Calculator = Calculator.shared
    @State private var showToastAlert = false
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
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(buttonLayout, id: \.self) { type in
                            ButtonView2(buttonType: type, geoProxy: geo)
                        }
                    }
                    .environmentObject(calculator)
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


struct ButtonView2: View {
    @EnvironmentObject var calculator: Calculator
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
}
