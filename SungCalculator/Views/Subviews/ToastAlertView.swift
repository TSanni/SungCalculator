//
//  ToastAlertView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 5/26/25.
//

import SwiftUI

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
    ToastAlert()
}
