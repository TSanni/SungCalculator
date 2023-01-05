//
//  TopScreenView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct TopScreenView: View {
    @State private var placeholder: String = "708"
    @EnvironmentObject var calculator: CalclutaorClass
    @State private var animateLine = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            HStack(spacing: 0) {
                
                Text("\(calculator.textInput)")
                    .font(.largeTitle)
                    .addLine
                
//                MyTextField(currentText: $calculator.textInput, placeHolder: $placeholder)
//                    .font(.largeTitle)
//                    .multilineTextAlignment(.trailing)
            }
   
            Spacer()
            
            
            VStack(alignment: .trailing, spacing: 40) {
                Text(calculator.runningResult)
                    .font(.title)

                HStack(spacing: 30) {
                    OptionButtons(image: "clock", action: historyButtonAction)
                    
                    OptionButtons(image: "ruler", action: conversionButtonAction)
                    
                    OptionButtons(image: "x.squareroot", action: moreCalculationsButtonAction)

                    Spacer()
                    
                    Button {
                        calculator.removeLast()
                        calculator.updateRunningResult()
                    } label: {
                        Image(systemName: "delete.left")
                    }
                    .disabled(calculator.textInput.isEmpty ? true : false)
                    .tint(.green)
 

                }
                .font(.title2)
                .tint(.gray)
                .padding(.vertical)
            }
        }
        .onAppear {
            animateLine.toggle()
        }
        
    }
    
    
    
    
    func historyButtonAction() {
        
    }
    
    func conversionButtonAction() {
        
    }
    
    func moreCalculationsButtonAction() {
        
    }
}

struct OptionButtons: View {
    
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
        }
    }
}

struct TopScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TopScreenView()
            .environmentObject(CalclutaorClass())
//            .previewLayout(.sizeThatFits)
    }
}










//struct KeyboardView: View {
//    @State var text: String = ""
//    @State var placHolder: String = "Enter username"
//    var body: some View {
//        VStack {
//            Spacer()
//            MyTextField(currentText: $text, placeHolder: $placHolder)
//                .padding(.horizontal, 40.0)
//            Spacer()
//        }
//    }
//}

//struct MyTextField: UIViewRepresentable {
//    @Binding var currentText: String
//    @Binding var placeHolder: String
//
//    func makeUIView(context: Context) -> UITextField {
//        let textField = UITextField()
//        textField.inputView = UIView() // hiding keyboard
//        textField.inputAccessoryView = UIView() // hiding keyboard toolbar
//        textField.placeholder = placeHolder
//        textField.textColor = nil
//        textField.font = UIFont.systemFont(ofSize: 30)
//        textField.textAlignment = .right
//        textField.delegate = context.coordinator
//        return textField
//    }
//
//    func updateUIView(_ textField: UITextField, context: Context) {
//        textField.text = currentText
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(text: $currentText)
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        @Binding var text: String
//        init(text: Binding<String>) {
//            self._text = text
//        }
//    }
//}


