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
    static let appleUserRefKey = "appleUserRef"
    fileprivate static let usernameKey = "userName"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let pdgaNumberKey = "pdgaNumber"
    fileprivate static let emailKey = "email"
}

class User {
    var username: String
    let firstName: String
    let lastName: String
    var email: String
    let pdgaNumber: Int
    let userCKRecordID: CKRecord.ID
    var appleUserRef: CKRecord.Reference
    
    init(username: String, firstName: String, lastName: String, pdgaNumber: Int, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.pdgaNumber = pdgaNumber
        self.email = email
        self.userCKRecordID = ckRecordID
        self.appleUserRef = appleUserReference
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let username = ckRecord[UserConstants.usernameKey] as? String,
        let firstName = ckRecord[UserConstants.firstNameKey] as? String,
        let lastName = ckRecord[UserConstants.lastNameKey] as? String,
        let email = ckRecord[UserConstants.emailKey] as? String,
        let appleUserRef = ckRecord[UserConstants.appleUserRefKey] as? CKRecord.Reference,
        let pdgaNumber = ckRecord[UserConstants.pdgaNumberKey] as? Int
            else { return nil }
        
        self.init(username: username, firstName: firstName, lastName: lastName, pdgaNumber: pdgaNumber, email: email, appleUserReference: appleUserRef)
    }
}

extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserConstants.TypeKey, recordID: user.userCKRecordID)
        
        self.setValuesForKeys([
            UserConstants.usernameKey : user.username,
            UserConstants.firstNameKey : user.firstName,
            UserConstants.lastNameKey : user.lastName,
            UserConstants.emailKey : user.email,
            UserConstants.pdgaNumberKey : user.pdgaNumber,
            UserConstants.appleUserRefKey : user.appleUserRef
        ])
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userCKRecordID == rhs.userCKRecordID
    }
}

extension User: SearchableRecord {
    
}
