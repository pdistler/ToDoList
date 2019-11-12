//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 31.10.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    var toDoItem: ToDoItem
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItem.title)
                    .font(.title)
                Text(toDoItem.itemDescription)
                    .font(.body)
                Text(dateFormatter.string(from: toDoItem.dueDate)).font(.footnote)
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var item = getItem()
    
    static var previews: some View {
        
        ToDoItemView(toDoItem: item)
    }
    
    static func getItem() -> ToDoItem {
        let item = ToDoItem()
        item.title = "Titel"
        item.itemDescription = "Beschreibung"
        item.dueDate = Date()
        
        return item
    }
}
