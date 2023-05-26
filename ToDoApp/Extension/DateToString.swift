//
//  DateToString.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 23.05.23.
//

import UIKit

extension Date {
    func  createDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
