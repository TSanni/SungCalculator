//
//  UnitConverterScreen.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 1/9/23.
//

import SwiftUI

struct UnitConverterScreen: View {
    @State var highlightedID = 0
    @State var pickerSelection: ConversionOptions = .area
    @State var selected: String = ""
    @Namespace var namespace
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ConversionOptions.allCases, id: \.self) { option in
                        
                        ZStack {
                            
                            if selected == option.rawValue {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red)
                                    .matchedGeometryEffect(id: "circle", in: namespace)
                            }
                            Text(option.rawValue)
                            
                        }
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selected = option.rawValue
                                pickerSelection = option

                            }
                        }
                    }
                }
            }
            
            Divider()
            
            getConversionScreen()
        }
        
    }
    
    func getConversionScreen() -> some View {
        switch pickerSelection {
            case .area:
                let view = AreaView()
                return AnyView(view)
            case .length:
                let view = LengthView()
                return AnyView(view)
            default:
                return AnyView(Text("Hi"))
        }
    }
    
    
    func conversion() {
//        let input = Measurement(value: 10, unit: UnitLength.centimeters)
    }
    
    
}

struct UnitConverterScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnitConverterScreen()
            .previewDevice("iPhone 11 Pro Max")
    }
}




struct UnitButtons: View {
    var option: ConversionOptions
    @Binding var highlightedId: Int
    @Binding var pickerSelction: ConversionOptions
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        Button {
            highlightedId = option.id
            pickerSelction = option
        } label: {
            Text(option.rawValue)
                .foregroundColor(colorScheme == .light ? (option.id == highlightedId ? .black : .gray) : (option.id == highlightedId ? .white : .gray))
                .padding()
        }
        .background {
            option.id == highlightedId ? Color.gray.opacity(0.2) : nil
        }
        .clipShape(Capsule())
    }
}



struct AreaView: View {
    
//    @Binding var pickerSelection: ConversionOptions
    @State var pickerSelection: AreaConversionOptions = .acres
    @State private var textInput = "Area#"
    @State private var textInput2 = "Area#2"

    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    Picker("Hi", selection: $pickerSelection) {
                        ForEach(AreaConversionOptions.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(textInput)
                }
            }
            
            VStack {
                HStack {
                    Picker("Hi", selection: $pickerSelection) {
                        ForEach(AreaConversionOptions.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(textInput2)
                }
            }
        }
    }
}



struct LengthView: View {
    
    //    @Binding var pickerSelection: ConversionOptions
    @State var pickerSelection: LengthConversionOptions = .millimeters
    @State var pickerSelection2: LengthConversionOptions = .millimeters

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Picker("Hi", selection: $pickerSelection) {
                        ForEach(LengthConversionOptions.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("717 cm^2")
                }
            }
            
            VStack {
                HStack {
                    Picker("Hi", selection: $pickerSelection2) {
                        ForEach(LengthConversionOptions.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("717 cm^2")
                }
            }
        }
    }
    
    
    
    
    
    
    
//    var computedAnswer: String {
//
//        var input = Measurement(value: 0, unit: UnitLength.millimeters)
//        var output = String(describing: input.converted(to: UnitLength.millimeters))
//
//        switch pickerSelection {
//            case .millimeters:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.millimeters)
//            case .centimeters:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.centimeters)
//            case .meters:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.meters)
//            case .kilometers:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.kilometers)
//            case .inches:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.inches)
//            case .feet:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.feet)
//            case .yards:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.yards)
//            case .miles:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.miles)
//            case .nauticalMiles:
//                input = Measurement(value: Double(typedInputValue) ?? 0, unit: UnitLength.nauticalMiles)
//
//        }
//
//
////        switch pickerSelection2 {
//            case .millimeters:
//                output = String(describing: input.converted(to: UnitLength.millimeters))
//            case .centimeters:
//                output = String(describing: input.converted(to: UnitLength.centimeters))
//            case .meters:
//                output = String(describing: input.converted(to: UnitLength.meters))
//            case .kilometers:
//                output = String(describing: input.converted(to: UnitLength.kilometers))
//            case .inches:
//                output = String(describing: input.converted(to: UnitLength.inches))
//            case .feet:
//                output = String(describing: input.converted(to: UnitLength.feet))
//            case .yards:
//                output = String(describing: input.converted(to: UnitLength.yards))
//            case .miles:
//                output = String(describing: input.converted(to: UnitLength.miles))
//            case .nauticalMiles:
//                output = String(describing: input.converted(to: UnitLength.nauticalMiles))
//        }
//
//        return output
//    }
}
