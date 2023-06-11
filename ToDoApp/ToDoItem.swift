//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

enum ToDoItemState: String {
    case Completed
    case Incomplete
}

struct ToDoItem: Codable {
    let createDate: Date
    var actionDate: Date
    var name: String
    var subscribe: String
    var state: ToDoItemState.RawValue 
}
