//
//  HistoryView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 1/5/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var calculator: Calculator
    @EnvironmentObject var persistence: PersistenceController
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    HStack {
                        LazyVStack(alignment: .trailing, spacing: 30) {
                            ForEach(persistence.savedEntities, id: \.dateAdded) { item in
                                VStack(alignment: .trailing, spacing: 10) {
                                    Text(item.entry ?? "No entry")
                                        .font(.subheadline)
                                    Text(item.result ?? "No result")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                }
                                .id(item.dateAdded)
                            }
                        }
                        .padding(.trailing)
                        
                        Divider()
                    }

                }
                .onAppear {
                    proxy.scrollTo(persistence.savedEntities.last?.dateAdded)
                }
            }
            
            Button {
                withAnimation {
                    calculator.toggleHistoryView()
                }
                persistence.deleteCalculationHistory()
            } label: {
                Text("Clear History")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Capsule()
                            .foregroundColor(.gray)
                    }
            }
            .padding(.horizontal)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .previewDevice("iPhone 11 Pro Max")
            .environmentObject(Calculator.shared)
            .environmentObject(PersistenceController.shared)
        
    }
}
