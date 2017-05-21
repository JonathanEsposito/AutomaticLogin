//
//  Profile.swift
//  Account
//
//  Created by .jsber on 04/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

class Login: NSObject, NSCoding {
    // MARK: - Properties
    var userName: String
    var password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    
    // MARK: - Types
    struct PropertyKey {
        static let userNameKey = "Yewt0Eic2upH1fom8Hem3buT4ci2or"
        static let passwordKey = "doutt9im2iF8veC0cook2def1oOc4e"
    }
    
    // MARK: - NSCoding
    required convenience init(coder aDecoder: NSCoder) {
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        self.init(userName: userName, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(password, forKey: "password")
    }
}
