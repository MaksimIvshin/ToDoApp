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
    
    func updateToDoItems() {
        let all = ToDoManagerImp.shared.fetchToDoList()
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
}
