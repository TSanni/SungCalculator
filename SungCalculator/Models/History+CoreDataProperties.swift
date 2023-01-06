//
//  History+CoreDataProperties.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 1/5/23.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var entry: String?
    @NSManaged public var result: String?
    @NSManaged public var dateAdded: Date?
    
    
    public var unwrappedEntry: String {
        entry ?? ""
    }
    
    public var unwrappedResult: String {
        result ?? ""
    }
    
    public var unwrappedDate: Date {
        dateAdded ?? Date.now
    }

}

extension History : Identifiable {

}
