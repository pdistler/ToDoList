//
//  ToDoItemDetailView.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 01.11.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import SwiftUI

struct ToDoItemDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var title = ""
    @State var dueDate = Date()
    @State var itemDescription = ""
    @State var priority = 2
    
    @State var toDoItem: ToDoItem?
    
    init(toDoItem: ToDoItem? = nil) {
        self.toDoItem = toDoItem
    }
    
    var body: some View {
        Form {
            TextField("Titel", text: $title) {
            }
            TextField("Beschreibung", text: $itemDescription) {
            }
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("Fälligkeit") })
            
            Button(action: {
                self.saveItem()
            }, label: {
                Text("Save")
            })
        }
        .onAppear {
            if let toDo = self.toDoItem {
                self.title = toDo.title
                self.itemDescription = toDo.itemDescription ?? ""
                self.dueDate = toDo.dueDate ?? Date()
                self.priority = toDo.priority
            }
        }
    }
    
    fileprivate func saveItem() {
        if self.toDoItem == nil {
            self.toDoItem = ToDoItem(context: self.managedObjectContext)
        }
        
        self.toDoItem?.creationDate = Date()
        self.toDoItem?.title = self.title
        self.toDoItem?.itemDescription = self.itemDescription
        self.toDoItem?.dueDate = self.dueDate
        self.toDoItem?.priority = self.priority
        self.toDoItem?.done = false
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ToDoItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemDetailView(toDoItem: ToDoItem())
    }
}
