//  Task.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

/*
 To-Do List:
 
 Final:
 - Impliment a persistance system. (Hard)
 - Would be implimented as an import task function inside the task class. May return array of tasks?
 */


import Foundation

class Task {
    internal var name: String
    internal var description: String
    internal var status: Status
    internal var finishDate: Date
    internal var priority: Priority
    
    enum Status{
        case Incomplete
        case Complete
    }
    
    enum Priority {
        case Low
        case Normal
        case High
    }
    
    init(Name: String, Description: String, finishBy timeToComplete: Date) {
        self.name = Name
        self.description = Description
        self.status = .Incomplete
        self.finishDate = timeToComplete
        self.priority = .Normal
    }
    
    func changeStatus() {
        if self.status == .Incomplete {
            self.status = .Complete
        } else {
            self.status = .Incomplete
        }
    }
    
    func changePriority(to priority: Priority) {
        self.priority = priority
    }
    
    func changeName(to name: String) {
        self.name = name
    }
    
    func changeDescription(to description: String) {
        self.description = description
    }
    
    func changeFinishDate(to finishDate: Date) {
        self.finishDate = finishDate
    }
    
    func print() {
        let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy"
        
        Swift.print("Task Name: \(name)\nStatus: \(status)\nPriority: \(priority)\nFinish By: \(format.string(from: finishDate))\nDescription: \(description)")
    }

    /*
     To-Do List:
     - importTasks(File: "file.name") ~Import tasks from file for persistance.
     - exportTakss(Tasks: [Task], File: "file.name") ~Export tasks to a file for persistance.
    */

}
