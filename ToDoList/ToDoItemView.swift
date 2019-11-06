//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 31.10.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
//    var toDoItem: ToDoItem
    let title: String
    let itemDescription: String
    let dueDate: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(itemDescription)
                    .font(.body)
                Text(dueDate)
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var item = getItem()
    
    static var previews: some View {
        
        ToDoItemView(title: item.title, itemDescription: item.itemDescription ?? "", dueDate: "\(item.dueDate!)")
    }
    
    static func getItem() -> ToDoItem {
        let item = ToDoItem()
        item.title = "Titel"
        item.itemDescription = "Beschreibung"
        item.dueDate = Date()
        
        return item
    }
}
