//
//  CalculatorClass.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/27/22.
//

import Foundation

class CalclutaorClass: ObservableObject {
    @Published var textInput: String = ""
    @Published var runningResult: String = ""
    private var lastCharacterIsSymbol = false
    private var newNumberInString = true
     var possibleToAddDecimal = true
    

    func addInteger(num: String) {
        if let number = Int(num) {
            textInput.append("\(number)")
            lastCharacterIsSymbol = false
            //Maybe add number formatter here?
//            formatNumberToAddCommas(num: textInput)

        }
    }
    
    //To be used in the ButtonView to check the symbol
    func checkSymbol(sym: ButtonType) {
        switch sym {
            case .parenthesis:
                handleParenthesis()
//                addSymbol(symbol: sym.rawValue)
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
//                addSymbol(symbol: sym.rawValue)
            case .negative:
                handleNegativeButton()
//                addSymbol(symbol: sym.rawValue)
            default:
                break
                
        }
    }
    
    private func addSymbol(symbol: String) {
        if let lastCharacter = textInput.last {
            
            if symbol == "%" {
                if lastCharacterIsSymbol {
                    textInput.removeLast()
                    textInput.append(symbol)
                    lastCharacterIsSymbol = false
                    return
                }
                
                lastCharacterIsSymbol = false
                textInput.append(symbol)
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
        if textInput.isEmpty {
            textInput.append("-")
            lastCharacterIsSymbol = true
            return
        }
        
        if lastCharacterIsSymbol {
            textInput.append("-")
            lastCharacterIsSymbol = true
            return
        }
        
        if textInput.count == 1 && textInput.last == "-" {
            textInput.removeLast()
            lastCharacterIsSymbol = false
            return
        }
    }
    
    func handleParenthesis() {
        
    }
    
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
    
    
    func getResult() {
        
        if textInput.isEmpty {
            print("CALLING getResult()... textInput IS EMPTY: RETURNING..")
            return
        }
        if lastCharacterIsSymbol {
            print("CALLING getResult()... INVALID ENTRY BECAUSE LAST CHARACTER IS A SYMBOL... RETURNING..")
//            print("INVALID FORMAT USED")
            return
        }
        var textInputForExpression = textInput.replacingOccurrences(of: "×", with: "*")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "÷", with: "/")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "%", with: "*0.01")
        
        if textInputForExpression.last != "." {
            
            let expression = NSExpression(format: textInputForExpression)
            let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as! Double
            
            print("RESULT IS: \(Float(result))")
            let resultString = formatResult(result: result)

            
            textInput = resultString
            
        }
    }
    
    func updateRunningResult() {
        print("GET RESULTS")
        if textInput.isEmpty {
            runningResult = ""
            return
        }
        
        
        if textInput.last == "+" || textInput.last == "×" || textInput.last == "÷" || textInput.last == "-" {
            print("LAST ELEMENT IS A SYMBOL")
            lastCharacterIsSymbol = true
            runningResult = ""
            return
        }
        
        
        if lastCharacterIsSymbol {
            print("INVALID FORMAT USED")
            runningResult = ""
            return
        }
        var textInputForExpression = textInput.replacingOccurrences(of: "×", with: "*")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "÷", with: "/")
        textInputForExpression = textInputForExpression.replacingOccurrences(of: "%", with: "*0.01")
        
        if textInputForExpression.last != "." {
            let expression = NSExpression(format: textInputForExpression)
            
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
    
    private func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
//            return String(format: "%.2f", result)
            return String(result)
        }
    }
    
    
    
    func clearAll() {
        textInput.removeAll()
        runningResult.removeAll()
        possibleToAddDecimal = true
    }
    
    func removeLast() {
        //If the textInput string is not empty, then remove element from the stack
        if !textInput.isEmpty {
            if textInput.last == "." { possibleToAddDecimal = true}
            
            textInput.removeLast()
            //After removing element from the stack, if the next element is not a symbol, lastCharacterIsSymbol is set to false 
            if textInput.last != "+" || textInput.last != "×" || textInput.last != "÷" || textInput.last != "%" {
                lastCharacterIsSymbol = false
            }
        }
    }
    
}





//NSExpression does not work good with floating point numbers.
//Using this extention to make it work with floating point numbers 
extension NSExpression {

    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
           return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        }
        return self
    }
}
