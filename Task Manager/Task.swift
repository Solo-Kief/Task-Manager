//  Task.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Task {
    private var name: String
    private var description: String
    private var status: Status
    private var finishDate: Date
    private var priority: Priority
    
    enum Status{
        case Incomplete
        case Complete
    }
    
    enum Priority {
        case Low
        case Normal
        case High
    }
    
    init(Name: String, Description: String, timeToComplete finishBy: String) {
        self.name = Name
        self.description = Description
        self.status = .Incomplete
        self.finishDate = Date().addingTimeInterval(604800) //Finish by one week from now.
        self.priority = .Normal
    }
    
    func changeStatus(of task: Task) {
        if task.status == .Incomplete {
            task.status = .Complete
        } else {
            task.status = .Incomplete
        }
    }
    
    func changePriority(of task: Task, to priority: Priority) {
        task.priority = priority
    }
    
    func changeName(of task: Task, to name: String) {
        task.name = name
    }
    
    func changeDescription(of task: Task, to description: String) {
        task.description = description
    }
    
    func changeFinishDate(of task: Task, to finishDate: Date) {
        task.finishDate = finishDate
    }
    
    func print() {
        Swift.print("Task Name: \(name)\nPriortiy: \(priority)\n Finish By: \(finishDate)\n Description: \(description)")
    }

    /*
     To-Do List:
     - importTasks(File: "file.name") ~Import tasks from file for persistance.
     - exportTakss(Tasks: [Task], File: "file.name") ~Export tasks to a file for persistance.
    */

}
