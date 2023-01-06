//
//  HistoryView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 1/5/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var calculator: CalclutaorClass
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)], animation: .easeInOut) var history: FetchedResults<History>
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                
                
                HStack {
                    LazyVStack(alignment: .trailing, spacing: 30) {
                        ForEach(history) { item in
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(item.unwrappedEntry)
                                    .font(.subheadline)
                                Text(item.unwrappedResult)
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.trailing)
                    
                    Divider()
                }
                
            }
            
            Button {
                handleDeleteAllHistoryButton()
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
    
    
    func handleDeleteAllHistoryButton() {
        
        for i in history {
            moc.delete(i)
        }
        withAnimation {
            calculator.showHistoryView = false
        }
        
        do {
            try moc.save()
        } catch {
            print("Error deleting all calculation history")
            return
        }

    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .previewDevice("iPhone 11 Pro Max")
            .environmentObject(CalclutaorClass())
        
    }
}
