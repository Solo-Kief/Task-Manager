//  Task.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  Persistance Code by Jacob Finn.

import Foundation

class Task: NSObject, NSCoding {
    internal var name: String
    internal var Tdescription: String
    internal var status: Status
    internal var finishDate: Date
    internal var priority: Priority
    
    internal enum Status: Int, Codable {
        case Incomplete = 0
        case Complete = 1
    }
    
    internal enum Priority: Int, Codable {
        case Low = 0
        case Normal = 1
        case High = 2
    }
    
    func encode(with aCoder: NSCoder) { //Used to encode a Task object to be saved.
        aCoder.encode(self.name , forKey: "name")
        aCoder.encode(self.Tdescription, forKey: "description")
        aCoder.encode(self.status.rawValue, forKey: "status")
        aCoder.encode(self.finishDate, forKey: "finishDate")
        aCoder.encode(self.priority.rawValue, forKey: "priority")
    }
    
    override init() { //Initialize Empty Task. For internal use only.
        self.name = ""
        self.Tdescription = ""
        self.status = .Incomplete
        self.finishDate = Date()
        self.priority = .Low
    }
    
    init(Name: String, Description: String, finishBy timeToComplete: Date) { //Normal Initializer
        self.name = Name
        self.Tdescription = Description
        self.status = .Incomplete
        self.finishDate = timeToComplete
        self.priority = .Normal
    }
    
    init(name: String, description: String, priorityRawValue: Int, finishDate: Date?, statusRawValue: Int) { //Initializer used for loading a saved task.
        self.name = name
        self.Tdescription = description
        self.status = Status(rawValue: statusRawValue)!
        self.priority = Priority(rawValue: priorityRawValue)!
        self.finishDate = finishDate!
    }
    
    convenience required init?(coder aDecoder: NSCoder) { //Used to decode and initialize a saved task.
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let description = aDecoder.decodeObject(forKey: "description") as! String
        let status = aDecoder.decodeInteger(forKey: "status")
        let finishDate = aDecoder.decodeObject(forKey: "finishDate") as! Date?
        let priority = aDecoder.decodeInteger(forKey: "priority")
        self.init(name: name, description: description, priorityRawValue: priority, finishDate: finishDate, statusRawValue: status)
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
        self.Tdescription = description
    }
    
    func changeFinishDate(to finishDate: Date) {
        self.finishDate = finishDate
    }
    
    func print() {
        let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy"
        
        Swift.print("Task Name: \(name)\nStatus: \(status)\nPriority: \(priority)\nFinish By: \(format.string(from: finishDate))\nDescription: \(Tdescription)")
    }
    
    func save(tasks: [Task]) { //Credit for save/load code to Jacob Finn.
        let storedTasks = NSKeyedArchiver.archivedData(withRootObject: tasks)
        UserDefaults.standard.set(storedTasks, forKey: "storedTasks")
    }
    
    func load() -> [Task] { //Code appears to use some form of built in OS User by User storage location.
        let storedTasks = UserDefaults.standard.value(forKey: "storedTasks")
        let taskArray = NSKeyedUnarchiver.unarchiveObject(with: storedTasks as! Data)
        return taskArray as! [Task]
    }
}
