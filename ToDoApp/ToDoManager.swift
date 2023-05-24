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
    func remove(with date: Date)
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

    func save(toDoItem: ToDoItem) {
        toDoList.append(toDoItem)
    }

    func remove(with date: Date) {
        toDoList.removeAll(where: {$0.createDate == date })
    }

    func getMockModel() -> ToDoItem {
        var timeInt = Date().timeIntervalSince1970
        timeInt += (60 * 60 * 24 * 10)
        let experationDate = Date(timeIntervalSince1970: timeInt)
        return
            .init(createDate: Date(), actionDate: experationDate, name: "Сделать HW ", subscribe: "Сделать мокковую модель")
    }
}
