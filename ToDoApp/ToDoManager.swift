//
//  ToDoManager.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

protocol ToDoManager {
    var toDoList: [ToDoItem] { get }
    
    func fetchToDoList (date: Date? ) -> [ToDoItem]
    func save(toDoItem: ToDoItem)
    func remove()
}

final class ToDoManagerImp: ToDoManager {

    static let shared = ToDoManagerImp()
    var toDoList: [ToDoItem] = []

    private init() { }
    
    func fetchToDoList (date: Date? = nil) -> [ToDoItem] {
        if let date {
            return toDoList.filter({ $0.actionDate > date})
        } else {
            return toDoList
        }
    }

    func saveData() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(toDoList), forKey: "toDoItems")
    }

    func save(toDoItem: ToDoItem) {
        toDoList.append(toDoItem)
        saveData()
    }

    func mySavedToDoItems() {
        if let myToDoItems = UserDefaults.standard.value(forKey: "toDoItems") as? Data {
            toDoList = try! PropertyListDecoder().decode(Array<ToDoItem>.self, from: myToDoItems)
        }
    }

    func remove() {
       // toDoList.removeAll(where: {$0.createDate == date })
        UserDefaults.standard.removeObject(forKey: "toDoItems")
    }
}
