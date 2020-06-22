//
//  ScoreCard.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/22/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit
import CloudKit

struct ScoreStrings {
    static let recordTypeKey = "ScoreCard"
    fileprivate static let playersKey = "players"
    fileprivate static let holesKey = "holes"
    fileprivate static let totalScoreKey = "totalScore"
    fileprivate static let scoresKey = "scores"
    fileprivate static let userReferenceKey = "userReference"
}

class ScoreCard {
    var players: [User?]
    var recordID: CKRecord.ID
    var userReferences: [CKRecord.Reference?]
    var holes: Int
    var scores: [Int: Int]
    
    init(players: [User?], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), userReferences: [CKRecord.Reference?], holes: Int, scores: [Int: Int]) {
        
        self.players = players
        self.recordID = recordID
        self.userReferences = userReferences
        self.holes = holes
        self.scores = scores
        
    }
}

extension ScoreCard {
    convenience init?(ckRecord: CKRecord) {
        guard let players = ckRecord[ScoreStrings.playersKey] as? [User],
            let userReferences = ckRecord[ScoreStrings.userReferenceKey] as? [CKRecord.Reference],
            let holes = ckRecord[ScoreStrings.holesKey] as? Int,
            let scores = ckRecord[ScoreStrings.scoresKey] as? [Int:Int] else { return nil }
        
        
        
        self.init(players: players, recordID: ckRecord.recordID, userReferences: userReferences, holes: holes, scores: scores)
    }
}
