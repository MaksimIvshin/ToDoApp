//
//  NSObject+Extension.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 2.06.23.
//

import Foundation

extension NSObject {
    static var identifier: String {
        String(describing: self)
    }
}
