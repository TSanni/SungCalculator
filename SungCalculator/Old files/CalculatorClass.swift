//
//  CalculatorClass.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/27/22.
//

import Foundation
import SwiftUI

class CalclutaorClass: ObservableObject {
    static let shared = CalclutaorClass()
    private var possibleToAddDecimal = true
    private var lastIsOperation = false
    let persistence = PersistenceController.shared

    @Published var textInput: String = ""
    @Published var result: String = ""
    @Published var runningResult: String = " " //Set runningResult to " " around this class to prevent the screen jump
    @Published var showHistoryView = false
    @Published var customTextView: CustomTextView?

//    private var lastCharacterIsNegativeSymbol = false


    private init() { }
    
    
    //MARK: - Public Functions
    func toggleHistoryView() {
        withAnimation {
            showHistoryView.toggle()
        }
    }
    
    func handleButtonInput(buttonInput: ButtonType) {
        
        // Top View Buttons
        if buttonInput == .historyButton {
            
        }
        
        if buttonInput == .rulerButton {
            
        }
        
        if buttonInput == .squareRootButton {
            
        }
        
        if buttonInput == .deleteButton {
            deleteButtonInput()
        }
        
        
        // Bottom View Buttons

        if buttonInput == .clear {
            handleClearButtonInput()
        }
        
        if buttonInput == .squared {
            handleSquareButton()
        }
        
        if buttonInput == .percent {
            handlePercentButton()
        }
        
        if buttonInput.isOperation {
            handleOperationButtonInput(value: buttonInput.rawValue)
        }
        
        if buttonInput.isInt {
            handleIntegerButtonInput(value: buttonInput.rawValue)
        }
        
        if buttonInput == .decimal {
            handleDecimalButton()
        }
        
        if buttonInput == .equal {
            handleEqualButtonInput()
        }
        
        if buttonInput == .negative {
            handleNegativeButtonInput()
        }
        
        getRunningResult()
        
    }
    
    // Top View Button Functions
    private func deleteButtonInput() {
        
        customTextView?.deleteText()
        
        if let last = customTextView?.textView.text.last {
            let a = String(last)
            
            if a == "%" || a == "²" {
                lastIsOperation = false
                return
            }
            
            let b = Int(a)
            
            if b != nil {
                lastIsOperation = false
            } else {
                lastIsOperation = true
            }
        }

    }

    // Bottom View Button Functions
    private func handleClearButtonInput() {
        customTextView?.textView.text = ""
        lastIsOperation = false
        possibleToAddDecimal = true
    }
    
    private func handleSquareButton() {
        guard let customTextViewText = customTextView?.textView.text else { return }
        if customTextViewText.isEmpty { return }
        if lastIsOperation || customTextViewText.last == "²" {
            return
        }
        print(lastIsOperation)
        customTextView?.insertText("²")
    }

    private func handlePercentButton() {
        guard let customTextViewText = customTextView?.textView.text, !customTextViewText.isEmpty else { return }
        if customTextViewText.last == "²" {
            customTextView?.insertText("%")
            return
        }
        
        if lastIsOperation  {
            return
        }
        print(lastIsOperation)
        customTextView?.insertText("%")
    }
    
    private func handleOperationButtonInput(value: String) {
        guard let customTextViewText = customTextView?.textView.text else { return }
        if customTextViewText.isEmpty || lastIsOperation == true {
            return
        }
        customTextView?.insertText(value)
        lastIsOperation = true
        possibleToAddDecimal = true
    }
    
    private func handleIntegerButtonInput(value: String) {
        customTextView?.insertText(value)
        lastIsOperation = false
    }

    private func handleDecimalButton() {
        guard let customTextViewText = customTextView?.textView.text else { return }
        if (customTextViewText.isEmpty || lastIsOperation) && possibleToAddDecimal {
            customTextView?.insertText("0.")
            lastIsOperation = true
            possibleToAddDecimal = false
            return
        }
        
        if customTextViewText.last == "-" {
            return
        }
        
        if possibleToAddDecimal {
            customTextView?.insertText(".")
            possibleToAddDecimal = false
            lastIsOperation = true
            
        }
    }
    
    private func handleEqualButtonInput() {
        guard let textInput = customTextView?.textView.text, !textInput.isEmpty else { return }
        if let result = useNSExpression() {
            if result == "NaN" || result == "inf" {
                customTextView?.textView.text = ""
            } else {
                customTextView?.textView.text = result
            }
            self.result = result
            persistence.addFruit(entry: textInput, result: result)
        }
    }
    
    private func getRunningResult() {
        self.runningResult = useNSExpression() ?? ""
    }
    
    private func useNSExpression() -> String? {
        print(#function)
        guard let textInput = customTextView?.textView.text, !textInput.isEmpty, textInput.last != "." else { return nil }
        guard lastIsOperation == false else { return nil }
        guard textInput.last != "." else { return nil }
        
        if textInput.count == 1 || textInput.last == "-" {
            return nil
        }
        
        if textInput.contains("0÷0") {
            print("Divide by 0!")
            return "NaN"
        }
        
        if textInput.contains("inf") {
            print("Infinite number")
            return "inf"
        }
        self.textInput = textInput
        var textInputForExpression = textInput.replacingOccurrences(of: "×", with: "*")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "÷", with: "/")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "%", with: "*0.01")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "²", with: "**2")

        let expression = NSExpression(format: textInputForExpression)
        let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double
        let highestNumberBeforeScientificNotation: Double = 10000000000000000 // 17 digits
        if let result = result {
            if result < highestNumberBeforeScientificNotation {
                let decimalNumber = formatNumber(num: result)
                return decimalNumber
            }
            return String(result)
        } else {
            return nil
        }
    }
    
    private func formatNumber(num: Double) -> String? {
        let largeNumber = num
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
        return formattedNumber
    }
    
    private func handleNegativeButtonInput() {
        guard let customTextViewText = customTextView?.textView.text else { return }
        if customTextViewText.isEmpty {
            customTextView?.insertText("-")
        }
        
        if customTextViewText.last == "." {
            return
        }
        
        if lastIsOperation {
            customTextView?.insertText("-")
        }
    }
    
}




//MARK: - Old


/*
 
 func addInteger(num: String) {
     if let number = Int(num) {
//            textInput.append("\(number)")
         customTextField?.insertText("\(number)")
         lastCharacterIsSymbol = false
         lastCharacterIsNegativeSymbol = false
     }
 }
 
 //To be used in the ButtonView to check the symbol
 func checkSymbol(sym: ButtonType) {
     switch sym {
         case .squared:
             print("Squared")
             addSymbol(symbol: sym.rawValue)
//                handleSquared()
         case .percent:
             addSymbol(symbol: sym.rawValue)
         case .divide:
             addSymbol(symbol: sym.rawValue)
         case .multiply:
             addSymbol(symbol: sym.rawValue)
         case .subtract:
             addSymbol(symbol: sym.rawValue)
         case .add:
             addSymbol(symbol: sym.rawValue)
         case .decimal:
             handleDecimalButton()
         case .negative:
             handleNegativeButton()
         default:
             break
             
     }
 }
 
 func clearAll() {
     textInput.removeAll()
     runningResult.removeAll()
     runningResult = " "
     possibleToAddDecimal = true
     lastCharacterIsNegativeSymbol = false
     lastCharacterIsSymbol = false
 }
 
 func removeLast() {
     //If the textInput string is not empty, then remove element from the stack
     if !textInput.isEmpty {
         if textInput.last == "." { possibleToAddDecimal = true}
         
         if textInput.last == "-" { lastCharacterIsNegativeSymbol = false }
         
         textInput.removeLast()
         //After removing element from the stack, if the next element is not a symbol, lastCharacterIsSymbol is set to false
         if textInput.last != "+" || textInput.last != "×" || textInput.last != "÷" || textInput.last != "%" {
             lastCharacterIsSymbol = false
         }
         
         //After removing element from the stack, if the next element is "-", then lastCharacterIsNegativeSymbol is set to true
         if textInput.last == "-" {
             lastCharacterIsNegativeSymbol = true
         }
         
     }
 }
 
 func getResult(completion: (_ success: Bool) -> ()) {
     
     if textInput.isEmpty {
         print("CALLING getResult()... textInput IS EMPTY: RETURNING..")
         completion(false)
         return
     }
     if lastCharacterIsSymbol {
         print("CALLING getResult()... INVALID ENTRY BECAUSE LAST CHARACTER IS A SYMBOL... RETURNING..")
         completion(false)
         return
     }
     var textInputForExpression = textInput.replacingOccurrences(of: "×", with: "*")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "÷", with: "/")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "%", with: "*0.01")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "²", with: "**2")

     
     if textInputForExpression.last != "." {
         longEntry = textInput
         let expression = NSExpression(format: textInputForExpression)
         let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as! Double
         
         print("RESULT IS: \(Float(result))")
         let resultString = formatResult(result: result)

         
         textInput = resultString
         completion(true)
    
     }
 }
 
 func updateRunningResult() {
     print("GET RESULTS")
     if textInput.isEmpty {
         runningResult = " "
         return
     }


     if textInput.last == "+" || textInput.last == "×" || textInput.last == "÷" || textInput.last == "-" {
         print("LAST ELEMENT IS A SYMBOL")
         lastCharacterIsSymbol = true
         runningResult = " "
         return
     }


     if lastCharacterIsSymbol {
         print("INVALID FORMAT USED")
         runningResult = " "
         return
     }
     var textInputForExpression = textInput.replacingOccurrences(of: "×", with: "*")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "÷", with: "/")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "%", with: "*0.01")
     textInputForExpression = textInputForExpression.replacingOccurrences(of: "²", with: "**2")

     if textInputForExpression.last != "." {
         let expression = NSExpression(format: textInputForExpression)
         
//            let expression = NSExpression(format: "5**2")

         let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double

         if let properResult = result {
             let resultString = formatResult(result: properResult)
             runningResult = resultString


             if let formattedAnswer = formatNumberToAddCommas(num: resultString) {
                 print("FORMATTED ANSWER: \(formattedAnswer)")
                 self.runningResult = formattedAnswer
                 print("RUNNING RESULT: \(runningResult)")
                 return
             }
         }


     }


 }
 
 
 
 
 
 //MARK: - Private Functions
 private func addSymbol(symbol: String) {
     if let lastCharacter = textInput.last {
         
         if lastCharacter == "." {
             return
         }
         
         if lastCharacterIsNegativeSymbol {
             print("LAST IS NEGATIVE.. RETURNING")
             return
         }
         
         if symbol == "%" {
             if lastCharacterIsSymbol {
//                    textInput.removeLast()
//                    textInput.append(symbol)
//                    lastCharacterIsSymbol = false
                 return
             }
             
             lastCharacterIsSymbol = false
             textInput.append(symbol)
             lastCharacterIsSymbol = false
//                getResult()
             return
         }
         
         if symbol == "x²" {
             if lastCharacterIsSymbol {
//                    textInput.removeLast()
//                    textInput.append(symbol)
//                    lastCharacterIsSymbol = false
                 return
             }
             
             lastCharacterIsSymbol = false
             textInput.append("²")
             lastCharacterIsSymbol = false
//                getResult()
             return
         }
         

         if lastCharacter == symbol.last {
             print("INVALID INPUT")
             lastCharacterIsSymbol = true
             return
         }
         

         
         
         //if the last entry is a symbol, then replace it with the new symbol button press
         if !textInput.isEmpty && lastCharacterIsSymbol {
             textInput.removeLast()
             textInput.append(symbol)
             lastCharacterIsSymbol = true
             possibleToAddDecimal = true
             return
         }
                     
         textInput.append(symbol)
         lastCharacterIsSymbol = true
         possibleToAddDecimal = true
     }
 }
 
 private func handleNegativeButton() {
     
     
     
     if textInput.count == 1 && textInput.last == "-" {
         textInput.removeLast()
         lastCharacterIsSymbol = false
         lastCharacterIsNegativeSymbol = false
         return
     }
     
     if lastCharacterIsNegativeSymbol {
         return
     }
     
     if textInput.isEmpty {
         textInput.append("-")
         lastCharacterIsNegativeSymbol = true
//            lastCharacterIsSymbol = true
         return
     }
     

     
     if lastCharacterIsSymbol {
         textInput.append("-")
//            lastCharacterIsSymbol = true
         lastCharacterIsNegativeSymbol = true
         return
     }
     

 }
//
//    private func handleSquared() {
//        if textInput.isEmpty {
//            textInput.append("(")
//            return
//        }
//
//        if lastCharacterIsSymbol {
//            textInput.append("(")
//            return
//        }
//
//        if !lastCharacterIsSymbol {
//            textInput.append(")")
//        }
//
//
//    }
 
 private func handleDecimalButton() {
     
     if possibleToAddDecimal && textInput.isEmpty {
         textInput.append("0.")
         possibleToAddDecimal = false
     }
     
     if possibleToAddDecimal && lastCharacterIsSymbol {
         textInput.append("0.")
         possibleToAddDecimal = false
     }
     
     if possibleToAddDecimal {
         textInput.append(".")
         possibleToAddDecimal = false
     }
 }
 
 private func formatNumberToAddCommas(num: String) -> String? {
     let formatter = NumberFormatter()

     // Set up the NumberFormatter to use a thousands separator
     formatter.usesGroupingSeparator = true
     formatter.groupingSize = 3
     
     //Set it up to always display 2 decimal places.
     formatter.alwaysShowsDecimalSeparator = false
     formatter.minimumFractionDigits = 0
     formatter.maximumFractionDigits = 10
     
     if let number = Double(num) {
         // If the number formatter is able to output a string, log it to the console.
        if let string = formatter.string(from:NSNumber(value: number)) {
             print(string)
            return string
         }
     }
     
     return nil

 }
 
 private func formatResult(result: Double) -> String {
     if (result.truncatingRemainder(dividingBy: 1) == 0) {
         return String(format: "%.0f", result)
     } else {
//            return String(format: "%.2f", result)
         return String(result)
     }
 }
 
 
 
 
 */
