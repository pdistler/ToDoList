//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 31.10.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
    @NSManaged public var creationDate: Date
    @NSManaged public var title: String
    @NSManaged public var priority: Int
    @NSManaged public var itemDescription: String
    @NSManaged public var dueDate: Date
    @NSManaged public var done: Bool
    
    public override func awakeFromInsert() {
        dueDate = Date()
        creationDate = Date()
    }
}

extension ToDoItem {
    static func getUndoneToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        let dueDateSortDescriptor = NSSortDescriptor(key: "dueDate", ascending:  true)
        request.predicate = NSPredicate(format: "done == NO")
        request.sortDescriptors = [dueDateSortDescriptor, prioritySortDescriptor]
        
        return request
    }
    
    static func getDoneToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        let dueDateSortDescriptor = NSSortDescriptor(key: "dueDate", ascending:  true)
        
        request.predicate = NSPredicate(format: "done == YES")
        request.sortDescriptors = [dueDateSortDescriptor]
        
        return request
    }
}
