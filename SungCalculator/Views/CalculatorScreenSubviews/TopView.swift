//
//  TopView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 7/6/24.
//

import SwiftUI

struct TopView: View {
    @State var text: String = ""
    @EnvironmentObject var calculator: CalclutaorClass

    var body: some View {
            VStack(alignment: .trailing) {
                Group {
                    if calculator.customTextView == nil {
                        CustomTextView(text: $text, placeholder: "Enter text here")
                            .background(GeometryReader { geometry in
                                Color.clear.onAppear {
                                    calculator.customTextView = CustomTextView(text: $text, placeholder: "Enter text here")
                                }
                            })
                    } else {
                        calculator.customTextView
                    }
                }

                
                Text(calculator.runningResult)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.title)
                
//                TextEditor(text: $calculator.runningResult)
//                    .disabled(true)
                
                HStack(spacing: 40.0) {
                    TopButton(buttonImage: "clock", buttonAction: showHistory)
                    TopButton(buttonImage: "ruler", buttonAction: showUnitConverter)
                    TopButton(buttonImage: "x.squareroot", buttonAction: showScientificMode)
                    Spacer()
                    TopButton(buttonImage: "delete.backward", buttonAction: deleteButton)
                        .disabled(text.isEmpty ? true : false)
                        .tint(.green)
                }
                .tint(.gray)
                .padding(.vertical)
            }
            .padding(.horizontal)
    }
    
    func showHistory() {
        calculator.toggleHistoryView()
    }
    
    func showUnitConverter() {
        print(#function)
        print(text)
    }
    
    func showScientificMode() {
        print(#function)
    }
    
    func deleteButton() {
        print(#function)
        calculator.handleButtonInput(buttonInput: .deleteButton)
    }

}


struct TopButton: View {
    
    let buttonImage: String
    let buttonAction: () -> Void
    
    var body: some View {
        
        Button(action: buttonAction) {
            Image(systemName: buttonImage)
        }
    }
}


struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var textView = UITextView()

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView
        
        init(parent: CustomTextView) {
            self.parent = parent
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let allowedCharacters = CharacterSet.uppercaseLetters
            let characterSet = CharacterSet(charactersIn: text)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
    }
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        textView.textAlignment = .right
        textView.inputView = UIView() // hiding keyboard
        textView.inputAccessoryView = UIView() // hiding keyboard toolbar
        textView.font = UIFont.systemFont(ofSize: 30)
//        textView.isEditable = false
        textView.showsVerticalScrollIndicator = true
        textView.becomeFirstResponder()
        return textView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func insertText(_ newText: String) {
        textView.insertText(newText)
    }
    
    func deleteText() {
        textView.deleteBackward()
    }
}


#Preview {
    TopView()
        .environmentObject(CalclutaorClass.shared)
}
