//
//  ContentView.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 31.10.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getUndoneToDoItems()) var openToDoItems: FetchedResults<ToDoItem>
    @FetchRequest(fetchRequest: ToDoItem.getDoneToDoItems()) var doneToDoItems: FetchedResults<ToDoItem>
    @State var showDetailView = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ToDos")) {
                    ForEach(self.openToDoItems) { toDoItem in
                        
                        ToDoItemView(title: toDoItem.title, itemDescription: toDoItem.itemDescription ?? "", dueDate: "Heute")
                    }.onDelete { indexSet in
                        let deleteItem = self.openToDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
                Section(header: Text("Erledigt")) {
                    ForEach(self.doneToDoItems) { toDoItem in
                        ToDoItemView(title: toDoItem.title, itemDescription: toDoItem.itemDescription ?? "", dueDate: "Heute")
                    }.onDelete { indexSet in
                        let deleteItem = self.doneToDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("ToDos"))
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showDetailView = true
                
            }, label: {
                Image(systemName: "plus")
            }))
            }.sheet(isPresented: $showDetailView, onDismiss: {
                self.showDetailView = false
            }, content: {
                ToDoItemDetailView()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
