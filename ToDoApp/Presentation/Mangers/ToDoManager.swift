//
//  ToDoManager.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

struct ToDoItem: Codable {
    let createDate: Date
    var actionDate: Date
    var name: String
    var subscribe: String
    var isFinished: Bool
}

protocol ToDoManager {
    var toDoList: [ToDoItem] { get }
    func fetchToDoList (dateToDo: Date? ) -> [ToDoItem]
}

final class ToDoManagerImp: ToDoManager {
    static let shared = ToDoManagerImp()
    var changeHandler: (() -> Void)?
    internal lazy var toDoList: [ToDoItem] = []
    
    private init() { }
    
    func fetchToDoList (dateToDo: Date? = nil) -> [ToDoItem] {
        if let dateToDo {
            if let searchResult = toDoList.first(where: { $0.createDate == dateToDo }) {
                return [searchResult]
            } else {
                return toDoList
            }
        } else {
            return toDoList
        }
    }

    func save(toDoItem: ToDoItem) {
        toDoList.append(toDoItem)
        UserDefaults.standard.saveData()
    }

    func mySavedToDoItems() {
        if let myToDoItems = UserDefaults.standard.value(forKey: "toDoItems") as? Data {
            do {
                toDoList = try PropertyListDecoder().decode(Array<ToDoItem>.self, from: myToDoItems)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func remove(toDoItem: ToDoItem) {
        UserDefaults.standard.removeObject(forKey: "toDoItems")
    }
    
    func toggle(modelWith date: Date) {
        if let index = toDoList.firstIndex(where: { $0.createDate == date }) {
            let oldModel = toDoList.remove(at: index)
            let newStatus = oldModel.isFinished ? false : true
            let newModel = ToDoItem(createDate: oldModel.createDate,
                                    actionDate: oldModel.actionDate,
                                    name: oldModel.name,
                                    subscribe: oldModel.subscribe,
                                    isFinished: newStatus)
            toDoList.insert(newModel, at: index)
            UserDefaults.standard.saveData()
        }
        changeHandler?()
    }
    
    func getNewToDo() -> ToDoItem {
        var timeInterval = Date().timeIntervalSince1970
        timeInterval += (60 * 60 * 24 * 10)
        return .init(createDate: Date(),
                     actionDate: Date(),
                     name: "",
                     subscribe: "",
                     isFinished: false)
    }
}
