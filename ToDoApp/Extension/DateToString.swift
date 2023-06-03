//
//  DateToString.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 23.05.23.
//

import UIKit

extension Date {
    enum DateFormat: String {
        case iso = "yyyy-MM-dd'T'HH:mm:ssZ"
        case simple = "MMM d, h:mm a"
        case titleDate = "MMM d, yyyy"
    }

    var dateString: String {
        let formatter = DateFormatter()
        let dateFormat = "MMM d, h:mm a"
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }

    func create(with format: DateFormat) -> String {
        let formatter = DateFormatter()
        let dateFormat = format.rawValue
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
