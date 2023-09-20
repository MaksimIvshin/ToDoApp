//
//  UserDefaultsManager.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 14.07.23.
//

import Foundation 

extension UserDefaults {
    func saveData() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(ToDoManagerImp.shared.toDoList), forKey: "toDoItems")
    }

    func save(toDoItem: ToDoItem) {
        ToDoManagerImp.shared.toDoList.append(toDoItem)
        saveData()
    }

    func mySavedToDoItems() {
        if let myToDoItems = UserDefaults.standard.value(forKey: "toDoItems") as? Data {
            do {
                ToDoManagerImp.shared.toDoList = try PropertyListDecoder().decode(Array<ToDoItem>.self, from: myToDoItems)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: "toDoItems")
    }
}
