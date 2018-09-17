//  Password.swift
//  Task Manager
//
//  Created by Solomon Keiffer on 9/17/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Password: NSObject, NSCoding {
    private static var password = ""
    
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
    
    static func userSave() {
        print("Set a new password.")
        Password.password = readLine()!
        save()
    }
    
    static func save() {
        let password = NSKeyedArchiver.archivedData(withRootObject: Password.password)
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    static func Load() {
        guard var password = UserDefaults.standard.value(forKey: "password") else {
            return save()
        }
        password = NSKeyedUnarchiver.unarchiveObject(with: password as! Data)
        Password.password = password as! String
    }
    
    static func verify() -> Bool {
        Load()
        guard password != "" else {
            return true
        }
        print("Please enter the password.")
        let attempt = readLine()!
        return Password.password == attempt
    }
}
