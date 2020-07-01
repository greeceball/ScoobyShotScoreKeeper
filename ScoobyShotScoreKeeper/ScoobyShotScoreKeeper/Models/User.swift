//
//  User.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/8/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit
import CloudKit
import AuthenticationServices

struct UserConstants {
    static let TypeKey = "User"
    static let appleUserRefKey = "userReference"
    fileprivate static let usernameKey = "userName"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let pdgaNumberKey = "pdgaNumber"
    fileprivate static let emailKey = "email"
    
}

class User {
    var username: String?
    let firstName: String
    let lastName: String
    var email: String
    let pdgaNumber: Int?
    let recordID: CKRecord.ID
    var appleUserRef: CKRecord.Reference?
    
    init(username: String, firstName: String, lastName: String, pdgaNumber: Int?, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference?) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.pdgaNumber = pdgaNumber
        self.email = email
        self.recordID = ckRecordID
        self.appleUserRef = appleUserReference
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let username = ckRecord[UserConstants.usernameKey] as? String,
        let firstName = ckRecord[UserConstants.firstNameKey] as? String,
        let lastName = ckRecord[UserConstants.lastNameKey] as? String,
        let email = ckRecord[UserConstants.emailKey] as? String else { return nil }
        
            let appleUserRef = ckRecord[UserConstants.appleUserRefKey] as? CKRecord.Reference
            let pdgaNumber = ckRecord[UserConstants.pdgaNumberKey] as? Int
        
        self.init(username: username, firstName: firstName, lastName: lastName, pdgaNumber: pdgaNumber, email: email, appleUserReference: appleUserRef)
    }
}

extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserConstants.TypeKey, recordID: user.recordID)
        
        self.setValuesForKeys([
            
            UserConstants.firstNameKey : user.firstName,
            UserConstants.lastNameKey : user.lastName,
            UserConstants.emailKey : user.email,
            
        ])
        
        if user.username != nil {
            self.setValue(user.username, forKey: UserConstants.usernameKey)
        }
        if user.pdgaNumber != nil {
            self.setValue(user.pdgaNumber, forKey: UserConstants.pdgaNumberKey)
        }
        if user.appleUserRef != nil {
            self.setValue(user.appleUserRef, forKey: UserConstants.appleUserRefKey)
        }
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

extension User: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        guard let username = username else { return false }
        if username.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}
