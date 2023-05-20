//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

enum ToDoItemState {
    case expired
    case snoozed
    case waiting
}

struct ToDoItem {
    let createDate = Date()
    var actionDate: Date
    var name: String
    var state: ToDoItemState = .waiting
    var subscribe: String?
}
