//  Task.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Task {
    var name: String
    var description: String
    var status: Bool
    var finishDate: Date
    var priority: Priority
    
    enum Priority {
        case Low
        case Normal
        case High
    }
    
    init(Name: String, Description: String, timeToComplete finishBy: String) {
        self.name = Name
        self.description = Description
        self.status = false
        self.finishDate = Date().addingTimeInterval(604800) //Finish by one week from now.
        self.priority = .Normal
    }

}
