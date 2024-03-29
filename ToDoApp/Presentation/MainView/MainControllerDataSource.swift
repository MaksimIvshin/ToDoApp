//
//  MainControllerDataSource.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 16.06.23.
//

import Foundation

final class MainControllerDataSource {
    
    var completeCount: Int { completed.count }
    var notCompleteCount: Int { nonCompleted.count }
    var completed: [ToDoItem]
    var nonCompleted: [ToDoItem]
    var numberOfSections = 2
    
    init() {
        let all = ToDoManagerImp.shared.fetchToDoList()
        completed = all.filter({
            $0.isFinished
        })
        nonCompleted = all.filter({
            !$0.isFinished
        })
    }

    func updateToDoItems(_ date: Date) {
        let startOfTheDay = Calendar.current.startOfDay(for: date)
        let endOfTheDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfTheDay) ?? Date()
        let all = ToDoManagerImp.shared.fetchToDoList().filter({
            $0.actionDate >= startOfTheDay && $0.actionDate < endOfTheDay
        })
        completed = all.filter({
            $0.isFinished
        })
        nonCompleted = all.filter({
            !$0.isFinished
        })
    }
    
    func numberOfRowsInSection(
        section: Int
    ) -> Int {
        if section == 0 {
            return notCompleteCount
        } else {
            return completeCount
        }
    }
    
    func getTitle(for section: Int) -> String {
        if section == 0 {
            return "Incomplete"
        } else {
            return "Completed"
        }
    }
    
    func getModel(for indexPath: IndexPath) -> ToDoItem {
        switch indexPath.section {
        case 0:
            return nonCompleted[indexPath.row]
        case 1:
            return completed[indexPath.row]
        default:
            return ToDoManagerImp.shared.getNewToDo()
        }
    }

    func updateCounters() {
        nonCompleted = ToDoManagerImp.shared.fetchToDoList().filter({ !$0.isFinished })
        completed = ToDoManagerImp.shared.fetchToDoList().filter({ $0.isFinished })
    }

    func removeItem(indexPath: IndexPath) {
        var toDoItem: ToDoItem?
        if indexPath.section == 0 {
            if nonCompleted.indices.contains(indexPath.row) {
                toDoItem = nonCompleted[indexPath.row]
                nonCompleted.remove(at: indexPath.row)
            }
        } else {
            if completed.indices.contains(indexPath.row) {
                toDoItem = completed[indexPath.row]
                completed.remove(at: indexPath.row)
            }
        }
        guard let item = toDoItem else { return }
        if let index = ToDoManagerImp.shared.toDoList.firstIndex(of: item) {
            ToDoManagerImp.shared.toDoList.remove(at: index)
        }
        updateCounters()
    }
}
