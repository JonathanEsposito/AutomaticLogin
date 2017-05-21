//
//  Profile.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    var name: String?
    var userName: String
    var password: String
    
    init(name: String?, userName: String, password: String) {
        self.name = name
        self.userName = userName
        self.password = password
    }
    
    
    

    
    // MARK: - Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("profiles")
    
    // MARK: - Keys
    struct PropertyKey {
        static let nameKey = "Wi0Unt1in2Pi0wU4Worf3Ec0O"
        static let userNameKey = "eg4cOn4yug4nEn6Yit6fif9vE"
        static let passwordKey = "Rieb6vaz4lYcs3iRd2uv1reaR"
    }
    
    // MARK: - NSCoding
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String?
        let userName = aDecoder.decodeObject(forKey: PropertyKey.userNameKey) as! String
        let password = aDecoder.decodeObject(forKey: PropertyKey.passwordKey) as! String
        self.init(name: name, userName: userName, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(userName, forKey: PropertyKey.userNameKey)
        aCoder.encode(password, forKey: PropertyKey.passwordKey)
    }
}
