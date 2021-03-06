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
    @State var showDetailViewForEditing = false
    @State var selectedItem = ToDoItem()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ToDos")) {
                    ForEach(self.openToDoItems) { toDoItem in
                        ToDoItemView(toDoItem: toDoItem)
                            .onTapGesture {
                                self.selectedItem = toDoItem
                                self.showDetailViewForEditing = true
                        }
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
                        CompletedToDoItemView(toDoItem: toDoItem)
                        .onTapGesture {
                            self.selectedItem = toDoItem
                            self.showDetailViewForEditing = true
                        }
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
            .sheet(isPresented: $showDetailViewForEditing, onDismiss: {
                self.showDetailViewForEditing = false
            }, content: {
                ToDoItemDetailView(toDoItem: self.$selectedItem).environment(\.managedObjectContext, self.managedObjectContext)
            })
            .navigationBarTitle(Text("ToDos"))
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.newToDo()
                self.showDetailView = true
                
            }, label: {
                Image(systemName: "plus")
            }))
            }.sheet(isPresented: $showDetailView, onDismiss: {
                self.showDetailView = false
            }, content: {
                ToDoItemDetailView(toDoItem: self.$selectedItem).environment(\.managedObjectContext, self.managedObjectContext)
            })
    }
    
    func newToDo() {
        selectedItem = ToDoItem(context: managedObjectContext)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
