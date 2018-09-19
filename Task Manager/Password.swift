//  Password.swift
//  Task Manager
//
//  Created by Solomon Keiffer on 9/17/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  This cluster truck is what makes and stores the password.

import Foundation

class Password: NSObject, NSCoding {
    private static var password = "" //Value is same accross all instances.
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Password.password , forKey: "password")
    }
    
    init(password: String) {
        Password.password = password
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let password = aDecoder.decodeObject(forKey: "password") as! String
        self.init(password: password)
    }
    
    static func userSave() { //Users version of save()
        print("Set a new password.")
        Password.password = readLine()!
        save()
    }
    
    static func save() { //Updates the password in local storage.
        let password = NSKeyedArchiver.archivedData(withRootObject: Password.password)
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    static func Load() { //Loads the password from local storage.
        guard var password = UserDefaults.standard.value(forKey: "password") else {
            return save() //Load() crashes if a password hasn't been made before.
        } //So this guard statement protects from that by running save if there is no password.
        password = NSKeyedUnarchiver.unarchiveObject(with: password as! Data)
        Password.password = password as! String //I don't know why this warning is here. ^^^
    }
    
    static func verify() -> Bool { //Asks the user for the password then returns whether or not they were right.
        Load()
        guard password != "" else { //If the password is blank then it doesn't ask.
            return true
        }
        print("Please enter the password.")
        let attempt = readLine()!
        return Password.password == attempt
    }
}
