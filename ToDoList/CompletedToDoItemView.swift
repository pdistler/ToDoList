//
//  CompletedToDoItemView.swift
//  ToDoList
//
//  Created by Jean-Pierre Distler on 09.11.19.
//  Copyright © 2019 Jean-Pierre Distler. All rights reserved.
//

import SwiftUI

struct CompletedToDoItemView: View {
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
                        .strikethrough()
                    Text(toDoItem.itemDescription)
                        .font(.body)
                        .strikethrough()
                    Text(dateFormatter.string(from: toDoItem.dueDate))
                        .font(.footnote)
                        .strikethrough()
                }
            }
        }
    }

    struct CompletedToDoItemView_Previews: PreviewProvider {
        static var item = getItem()
        
        static var previews: some View {
            CompletedToDoItemView(toDoItem: item)
        }
        
        static func getItem() -> ToDoItem {
            let item = ToDoItem()
            item.title = "Titel"
            item.itemDescription = "Beschreibung"
            item.dueDate = Date()
            item.done = true
            
            return item
        }
    }
