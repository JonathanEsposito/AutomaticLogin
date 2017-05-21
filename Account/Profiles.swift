//
//  Profiles.swift
//  Account
//
//  Created by .jsber on 05/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

class Profiles {
    
    // MARK: - NSCoding
    class private func load() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.ArchiveURL.path) as? [Profile]
    }
    
    class private func save(profiles: [Profile]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profiles, toFile: Profile.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save profiles...")
        }
    }
    
    
    
    // MARK: - Public Methods
    class func addAndSave(newProfile: Profile) {
        var allProfiles = self.load()
        
        if allProfiles != nil {
            let sameUserName = allProfiles!.filter { $0.userName == newProfile.userName }
            if sameUserName.isEmpty {
                allProfiles!.append(newProfile)
                self.save(profiles: allProfiles!)
            } else {
                print("username already exists")
            }
        } else {
            print("your are our first user")
            self.save(profiles: [newProfile])
        }
    }
    
    class func isUnique(login: Login) -> Bool {
        let allProfiles = self.load()
        if allProfiles != nil {
            let sameUserName = allProfiles!.filter { $0.userName == login.userName }
            return sameUserName.isEmpty
        }
        return allProfiles == nil
    }
    
    class func checkCredentials(forLogin login: Login) -> Bool {
        let allProfiles = self.load()
        
        if allProfiles != nil {
            print("Profiles: \(allProfiles)")
            let sameUserName = allProfiles!.filter { $0.userName == login.userName}
            if sameUserName != [] {
                let savedPassword = sameUserName[0].password
                return savedPassword == login.password
            }
            print("no user with this userName found")
            return false
        }
        print("there seem to be no users registered yet")
        return false
    }
    
    class func getProfile(withUserName userName: String) -> Profile? {
        let allProfiles = self.load()
        if allProfiles != nil {
            let sameUserName = allProfiles!.filter { $0.userName == userName }
            if sameUserName != [] {
                return sameUserName[0]
            }
            print("no profile with this userName found")
            return nil
        }
        print("There seem to be no users yet..")
        return nil
    }
    
    class func update(profile: Profile) {
        let allProfiles = self.load()
        if allProfiles != nil, let profileIndex = allProfiles!.index(where: { $0.userName == profile.userName }) {
            var allProfilesUpdated = allProfiles!
            allProfilesUpdated[profileIndex] = profile
            self.save(profiles: allProfilesUpdated)
        }
    }
}
