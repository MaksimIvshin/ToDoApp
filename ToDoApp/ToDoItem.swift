//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

enum ToDoItemState: String {
    case expired
    case snoozed
    case waiting
}

struct ToDoItem {
    let createDate: Date
    var actionDate: Date
    var name: String
    var subscribe: String
    var state: ToDoItemState = .waiting
}
