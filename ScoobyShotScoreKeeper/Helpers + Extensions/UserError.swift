//
//  UserError.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/8/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation

enum UserError: Error {
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    case noUserLoggedIn
    case noUserForCollection

    var errorDescription: String {
        switch self {

        case .ckError(let error):
        return error.localizedDescription
        case .couldNotUnwrap:
        return "Unable to find a user"
        case .unexpectedRecordsFound:
        return "Unexpected records were returned when trying to delete."
        case .noUserLoggedIn:
        return "There is currently no user logged in."
        case .noUserForCollection:
        return "No user was found to be associated with this collection."
        }
    }
}
