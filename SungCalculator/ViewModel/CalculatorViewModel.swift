//
//  CalculatorViewModel.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/26/25.
//

import Foundation
import Expression

class CalculatorViewModel: ObservableObject {
    @Published var textInput = ""
    @Published var runningTotal = ""
    @Published var showError = false
    @Published var showHistoryView = false
    var arrayOfButtonTypes: [ButtonType] = []
    let persistence: PersistenceController

    static let shared = CalculatorViewModel(persistence: PersistenceController.shared)

    init(persistence: PersistenceController = PersistenceController.shared) {
        self.persistence = persistence
    }
    
    func toggleHistoryView() {
        showHistoryView.toggle()
    }
    
    private func handleDeleteButtonPressed() {
        print(#function)
        if textInput.isEmpty { return }
        
        textInput.removeLast()
        arrayOfButtonTypes.removeLast()
    }
    
    private func handleClearButtonPressed() {
        print(#function)
        textInput.removeAll()
        runningTotal.removeAll()
        arrayOfButtonTypes.removeAll()
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
    }
    
    // TODO: - Add more cases
    private func handleDecimalButtonPressed(buttonType: ButtonType) {
        // Ex) ""
        if textInput.isEmpty && arrayOfButtonTypes.isEmpty {
            textInput.append("0.")
            arrayOfButtonTypes.append(.zero)
            arrayOfButtonTypes.append(.decimal)
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
    }
    
    private func handlePercentButtonPressed(buttonType: ButtonType) {
        if textInput.isEmpty { return }
        
        textInput.append(buttonType.rawValue)
        arrayOfButtonTypes.append(buttonType)
    }
    
    private func handleSquaredButtonPressed(buttonType: ButtonType) {
        if textInput.isEmpty { return }

    }
    
    private func handleNegativeButtonPressed(buttonType: ButtonType) {
        
    }
    
    private func handleEqualsButtonPressed(buttonType: ButtonType) {
        let textInputCompatibleWithExpression = textInput
            .replacingOccurrences(of: ButtonType.multiply.rawValue, with: "*")
            .replacingOccurrences(of: ButtonType.divide.rawValue, with: "/")
            .replacingOccurrences(of: ButtonType.percent.rawValue, with: "*0.01")
        
        let expression = Expression(textInputCompatibleWithExpression)
        do {
            let result = try expression.evaluate()
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                persistence.addCalculation(entry: textInput, result: String(Int(result)))
                textInput = String(Int(result))
            } else {
                persistence.addCalculation(entry: textInput, result: result.description)
                textInput = result.description

            }
        } catch  {
           // let errorMessage = "Invalid format used"
            showError = true
        }
    }
    
    private func updateRunningTotal() {
        let textInputCompatibleWithExpression = textInput
            .replacingOccurrences(of: ButtonType.multiply.rawValue, with: "*")
            .replacingOccurrences(of: ButtonType.divide.rawValue, with: "/")
            .replacingOccurrences(of: ButtonType.percent.rawValue, with: "*0.01")

        
        let expression = Expression(textInputCompatibleWithExpression)
        do {
            let result = try expression.evaluate()
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                runningTotal = String(Int(result))
            } else {
                runningTotal = result.description
            }
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
