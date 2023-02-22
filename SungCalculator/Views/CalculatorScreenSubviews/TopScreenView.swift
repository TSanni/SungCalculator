//
//  TopScreenView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct TopScreenView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            HStack(spacing: 0) {
                
                Text("\(calculator.textInput)")
                    .font(.largeTitle)
                    .addLine
                    .minimumScaleFactor(0.5)
                
            }

            Spacer()
            
            
            VStack(alignment: .trailing, spacing: 40) {
                Text(calculator.runningResult)
                    .font(.title)
                    .minimumScaleFactor(0.5)


                HStack(spacing: 30) {
                    //Three option buttons on the left
                    OptionButtons(image: "clock", action: historyButtonAction)
                    
                    OptionButtons(image: "ruler", action: conversionButtonAction)
                    
                    OptionButtons(image: "x.squareroot", action: moreCalculationsButtonAction)

                    Spacer()
                    
                    //Backspace button on the right
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

        
    }
    
    
    
    private func historyButtonAction() {
        withAnimation {
            calculator.showHistoryView.toggle()
        }
    }
    
    private func conversionButtonAction() {
        
    }
    
    private func moreCalculationsButtonAction() {
        
    }
}

struct OptionButtons: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)], animation: .easeInOut) var history: FetchedResults<History>

    let image: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
        }
        .disabled(history.isEmpty && image == "clock" ? true : false) //if there is no history, disable button
    }
}

struct TopScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TopScreenView()
            .previewDevice("iPhone 11 Pro Max")
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


