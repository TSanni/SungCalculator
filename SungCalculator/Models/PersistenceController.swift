//
//  PersistenceController.swift
//  GWeather
//
//  Created by Tomas Sanni on 10/7/22.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    @Published var savedEntities: [History] = []
    
    private init() {
        container = NSPersistentContainer(name: "History")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA \(error)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<History>(entityName: "History")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(entry: String, result: String) {
        let historyObject = History(context: container.viewContext)
        historyObject.dateAdded = Date.now
        historyObject.result = result
        historyObject.entry = entry
        saveData()
    }
    
//    func updateFruit(entity: FruitEntity) {
//        let currentName = entity.name ?? ""
//        let newName = currentName + "!"
//        entity.name = newName
//        saveData()
//    }
    
    func deleteFruit() {
        for i in savedEntities {
            container.viewContext.delete(i)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}
