//
//  PersistenceController.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/7/22.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
    let container = NSPersistentContainer(name: "History")
    
    init() {
        container.loadPersistentStores { description, error in
            if let e = error {
                print("There was an error loading core data: \(e.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
}
