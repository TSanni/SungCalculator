//
//  SungCalculatorApp.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

@main
struct SungCalculatorApp: App {
    @StateObject var calculator: CalculatorViewModel = CalculatorViewModel.shared
    @StateObject var persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CalculatorScreen()
                .environmentObject(calculator)
                .environmentObject(persistence)
        }
    }
}
