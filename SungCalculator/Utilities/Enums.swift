//
//  Enums.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 1/9/23.
//

import Foundation
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
    case squared = "x²"
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
            case .squared:
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






enum ConversionOptions: String, CaseIterable {
    case area = "Area"
    case length = "Length"
    case temperature = "Temperature"
    case volume = "Volume"
    case mass = "Mass"
    case data = "Data"
    case speed = "Speed"
    case time = "Time"
    case tip = "Tip"
    
    
    var id: Int {
        switch self {
            case .area:
                return 1
            case .length:
                return 2
            case .temperature:
                return 3
            case .volume:
                return 4
            case .mass:
                return 5
            case .data:
                return 6
            case .speed:
                return 7
            case .time:
                return 8
            case .tip:
                return 9
        }
    }
    
}


enum AreaConversionOptions: String, CaseIterable {
    case acres = "Acres (ac)"
    case ares = "Ares (a)"
    case hectares = "Hectares (ha)"
    case squareCentimeters = "Square centimeters (cm^2)"
    case squareFeet = "Square feet (ft^2)"
    case squareInches = "Square inches (in^2)"
    case squareMeters = "Square meters (m^2)"
}

enum LengthConversionOptions: String, CaseIterable {
    case millimeters = "Millimeters (mm)"
    case centimeters = "Centimeters (cm)"
    case meters = "Meters (m)"
    case kilometers = "Kilometers (km)"
    case inches = "Inches (in)"
    case feet = "Feets (ft)"
    case yards = "Yards (yd)"
    case miles = "Miles (mi)"
    case nauticalMiles = "Nautical miles (NM)"
    case mils = "Mils (mil)"
}

enum TemperatureConversionOptions: String {
    case celsius = "Celsius (°C)"
    case fahrenheit = "Fahrenheit (°F)"
    case kelvin = "Kelvin (K)"
}


