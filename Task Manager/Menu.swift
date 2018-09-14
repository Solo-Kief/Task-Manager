//  Menu.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

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
        6. Save
        7. Load
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
        guard taskList.count > 0 else {
            print("This function is temporarily unavaliable because no tasks have been made.")
            return displayMainMenu()
        }
        
        print("""

        1. Change Task Name
        2. Change Task Description
        3. Change Task Complete-By Date
        4. Change Task Priority
        5. Toggle Task Complete / Incompete
        6. Delete Task
        7. Cancle

        """)
        
        guard let input = Int(readLine()!) else { //Insure input is a integer.
            print("Input given was not a number option.")
            sleep(1)
            return displayTaskEditorMenu()
        }
        
        var taskIndex = -1
        print("Enter the name of the task you want to edit...")
        let name = readLine()!
        
        for i in 0...taskList.count - 1 {
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
            print("\nWhat would you like to name your task?")
            let name = readLine()!
            
            print("\nPlease write a description of the task.")
            let description = readLine()!
            
            print("\nWhen does this task need to be finished? (mm/dd/yyyy)") //Get Task Date
            let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy" //Set format to stated format.
            
            guard let date = format.date(from: readLine()!) else{ //If date given does not conform
                print("\nAn improper date was given.\n")          //to format, then inform user and
                return displayMainMenu()                          //pass control back to main menu.
            }
            
            taskList.append(Task(Name: name, Description: description, finishBy: date))
        case 2:
            for task in taskList {
                print("")
                task.print()
                print("")
            }
        case 3:
            for task in taskList {
                if task.status == .Incomplete {
                    print("")
                    task.print()
                    print("")
                }
            }
        case 4:
            for task in taskList {
                if task.status == .Complete {
                    print("")
                    task.print()
                    print("")
                }
            }
        case 5:
            displayTaskEditorMenu()
        case 6:
            Task().save(tasks: taskList)
        case 7:
            taskList = Task().load()
        case 8:
            return //Boots out of this function, resulting in completion of the original file.
        default:
            print("\nInvalid Input\n")
            sleep(1)
        }
        displayMainMenu()
    }
    
    func secondaryInputHandler(Input: Int, Index: Int) {
        switch Input {
        case 1:
            print("\nWhat do you want to change the name to?")
            let newName = readLine()!
            taskList[Index].changeName(to: newName)
        case 2:
            print("\nPlease type a new task description...")
            let newDescription = readLine()!
            taskList[Index].changeDescription(to: newDescription)
        case 3:
            let format = DateFormatter(); format.dateFormat = "MM/dd/yyyy"
            
            guard let newDate = format.date(from: readLine()!) else {
                print("\nAn improper date was given.")
                return displayMainMenu()
            }
            
            taskList[Index].changeFinishDate(to: newDate)
        case 4:
            print("\nWhat do you want to set the new priority to? (0 - LOW || 1 - Normal || 2 - High)")
            guard let newPriority = Int(readLine()!) else {
                print("\nAn improper priority value was given.\n")
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
                print("\nAn improper priority value was given.\n")
                displayMainMenu()
            }
        case 5:
            taskList[Index].changeStatus()
            print("\nThe task \(taskList[Index].name) has been marked as \(taskList[Index].status).")
        case 6:
            taskList.remove(at: Index)
        case 7:
            displayMainMenu()
        default:
            print("\nInvalid Input\n")
            sleep(1)
        }
        displayMainMenu()
    }
}
