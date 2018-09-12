//  Menu.swift
//  Task Manager
//
//  Created by Solomon Kieffer on 9/12/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Menu {
    func displayMenu() {
        print("""
            1. Make A New Task
            2. List All Tasks
            3. List Incomplete Tasks
            4. List Complete Tasks
            5. Edit Task
            6. Save (Not Implemented)
            7. Quit
        """)
    }
    
    func inputHandler(Input: Int) {
        switch Input {
        case 1:
            <#code#>
        case 2:
            <#code#>
        case 3:
            <#code#>
        case 4:
            <#code#>
        case 5:
            <#code#>
        case 6:
            <#code#>
        case 7:
            <#code#>
        default:
            print("\nInvalid Input\n")
            sleep(1)
            displayMenu()
        }
    }
}
