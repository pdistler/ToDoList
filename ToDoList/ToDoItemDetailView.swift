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
    @State var done = false
    @State var priority = 2
    @Binding var toDoItem: ToDoItem
    
    init(toDoItem: Binding<ToDoItem>) {
        self._toDoItem = toDoItem
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Titel", text: $title) {
                }
                TextField("Beschreibung", text: $itemDescription) {
                }
                Toggle("Erledigt", isOn: $done)
                DatePicker(selection: $dueDate, in: Date()..., label: { Text("Fälligkeit") }) 
            }
            Button(action: {
                self.saveItem()
            }, label: {
                Text("Speichern")
            })
            
        }
        .onAppear {
            self.title = self.toDoItem.title
            self.itemDescription = self.toDoItem.itemDescription
            self.dueDate = self.toDoItem.dueDate
            self.priority = self.toDoItem.priority
            self.done = self.toDoItem.done
        }
    }
    
    fileprivate func saveItem() {
        self.toDoItem.creationDate = Date()
        self.toDoItem.title = self.title
        self.toDoItem.itemDescription = self.itemDescription
        self.toDoItem.dueDate = self.dueDate
        self.toDoItem.priority = self.priority
        self.toDoItem.done = self.done
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

//struct ToDoItemDetailView_Previews: PreviewProvider {
//    static var item = ToDoItem()
//    
//    static var previews: some View {
////        ToDoItemDetailView(toDoItem: item)
//    }
//}
