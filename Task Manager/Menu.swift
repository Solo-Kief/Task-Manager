//  Menu.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

/*Funtions:
- setStatus(Task: task, Status: Complete || Incomplete)
- setDueDate(Task: task, DueDate: date)
- setTaskPriority(Priority: priority)
- editTask(Task: task, Action: Name || Description)
- deleteTask(Task: task or taskID?)
*/

import Foundation

var taskList = [Task]()

class Menu {
    func displayMainMenu() {
        print("""
        1. Make A New Task
        2. List All Tasks
        3. List Incomplete Tasks
        4. List Completed Tasks
        5. Edit Task
        6. Save (Not Implemented)
        7. Load (Not Implemented)
        8. Quit
        """)
        
        guard let input = Int(readLine()!) else { //Insure input is a integer.
            print("Input given was not a number option.")
            sleep(1)
            return displayMainMenu()
        }
        
        primaryInputHandler(Input: input)
    }
    
    func displayTaskEditorMenu() {
        print("""
        1. Change Task Name
        2. Change Task Description
        3. Change Task Complete-By Date
        4. Change Task Priority
        5. Toggle Task Complete / Incompete
        6. Cancle
        """)
        
        guard let input = Int(readLine()!) else { //Insure input is a integer.
            print("Input given was not a number option.")
            sleep(1)
            return displayTaskEditorMenu()
        }
        
        var taskIndex = -1
        print("Enter the name of the task you want to edit...")
        let name = readLine()!
        for i in 0...taskList.count {
            if name.lowercased() == taskList[i].name.lowercased() {
                taskIndex = i
            }
        }
        
        guard taskIndex >= 0 else {
            print("No such task was found.")
            return displayMainMenu()
        }
        
        secondaryInputHandler(Input: input, Index: taskIndex)
    }
    
    func primaryInputHandler(Input: Int) {
        switch Input {
        case 1:
            print("What would you like to name your task?")
            let name = readLine()!
            
            print("Please write a description of the task.")
            let description = readLine()!
            
            print("When does this task need to be finished? (mm/dd/yyyy)") //Get Task Date
            let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy" //Set format to stated format.
            
            guard let date = format.date(from: readLine()!) else{ //If date given does not conform
                print("An improper date was given.")              //to format, then inform user and
                return displayMainMenu()                          //pass control back to main menu.
            }
            
            taskList.append(Task(Name: name, Description: description, finishBy: date))
        case 2:
            for task in taskList {
                task.print()
            }
        case 3:
            for task in taskList {
                if task.status == .Incomplete {
                    task.print()
                }
            }
        case 4:
            for task in taskList {
                if task.status == .Complete {
                    task.print()
                }
            }
        case 5:
            displayTaskEditorMenu()
        case 6:
            print("Function Not Avaliable.")
        case 7:
            print("Function Not Avaliable.")
        case 8:
            return //Boots out of this function, resulting in completion of the original file.
        default: //Insure input is within range.
            print("\nInvalid Input\n")
            sleep(1)
        }
        displayMainMenu()
    }
    
    func secondaryInputHandler(Input: Int, Index: Int) {
        switch Input {
        case 1:
            print("What do you want to change the name to?")
            let newName = readLine()!
            taskList[Index].changeName(to: newName)
        case 2:
            print("Please type a new task description...")
            let newDescription = readLine()!
            taskList[Index].changeDescription(to: newDescription)
        case 3:
            let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy"
            
            guard let newDate = format.date(from: readLine()!) else {
                print("An improper date was given.")
                return displayMainMenu()
            }
            
            taskList[Index].changeFinishDate(to: newDate)
        case 4:
            print("What do you want to set the new priority to? (0 - LOW || 1 - Normal || 2 - High)")
            guard let newPriority = Int(readLine()!) else {
                print("An improper priority value was given.")
                return displayMainMenu()
            }
            switch newPriority {
            case 0:
                taskList[Index].changePriority(to: .Low)
            case 1:
                taskList[Index].changePriority(to: .Normal)
            case 2:
                taskList[Index].changePriority(to: .High)
            default:
                print("An improper priority value was given.")
                displayMainMenu()
            }
        case 5:
            taskList[Index].changeStatus()
            print("The task \(taskList[Index].name) has been marked as \(taskList[Index].status).")
        case 6:
            displayMainMenu()
        default:
            print("\nInvalid Input\n")
            sleep(1)
        }
        displayMainMenu()
    }
}
