//
//  ScoreCardController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/30/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import CloudKit
import UIKit

class ScoreCardController {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    static let shared = ScoreCardController()
    var scoreCards: [ScoreCard] = []
    var playerReferences: [CKRecord.Reference] = []
    
    //MARK: - CRUD functions
    func saveScoreCard(players: [User], holes: Int, scores: [Int: Int], completion: @escaping (Result<ScoreCard?, ScoreCardError>) -> Void) {
        //guard let currentUser = UserController.shared.currentUser else { return completion(.failure(.noUserLoggedIn)) }
        
        //let reference = CKRecord.Reference(recordID: currentUser.recordID, action: .deleteSelf)
        
        for player in players {
            playerReferences.append(player.appleUserRef!)
        }
        let newScoreCard = ScoreCard(players: players, userReferences: playerReferences, holes: holes, scores: scores)
        
        let scoreCardRecord = CKRecord(scoreCard: newScoreCard)
        
        publicDB.save(scoreCardRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
            let savedScoreCard = ScoreCard(ckRecord: record)
                else { return completion(.failure(.couldNotUnwrap)) }
            print("Saved ScoreCard: \(record.recordID.recordName) Successfully")
            
            completion(.success(savedScoreCard))
        }
    }
    
    func fetchScoreCards(completion: @escaping (Result<[ScoreCard], ScoreCardError>) -> Void) {
        
        guard let currentUser = UserController.shared.currentUser else { return completion(.failure(.noUserLoggedIn)) }
        
        let reference = CKRecord.Reference(recordID: currentUser.recordID, action: .deleteSelf)
        let predicate = NSPredicate(format: "scoreCard == %2", reference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "ScoreCard", predicate: predicate)
        query.sortDescriptors = [sort]
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            let scoreCards = records.compactMap{( ScoreCard( ckRecord: $0 ) )}
            completion(.success(scoreCards))
        }
    }
    
    func updateScoreCard() {
        
    }
    
    func deleteScoreCard() {
        
    }
}
