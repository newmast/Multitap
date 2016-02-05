//
//  HighscoreDataHelper.swift
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation
import SQLite

protocol DataHelperProtocol {
    typealias T
    static func createTable() throws -> Void
    static func insert(item: T) throws -> NSNumber
    static func delete(item: T) throws -> Void
    static func findAll() throws -> [T]?
}


@objc class HighscoreDataHelper: NSObject, DataHelperProtocol {
    static let TABLE_NAME = "Highscores"
    
    static let table = Table(TABLE_NAME)
    static let highscoreId = Expression<NSNumber>("highscoreId")
    static let playerName = Expression<NSString>("playerName")
    static let score = Expression<NSNumber>("score")
    
    typealias T = Highscore
    
    func sayHello() {
        
    }
    
    static func createTable() throws {
        guard let DB = SqliteManager.sharedInstance.getConnection else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {table in
                table.column(highscoreId, primaryKey: true)
                table.column(playerName)
                table.column(score)
                })
        } catch _ {
            // Already exists
        }
        
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SqliteManager.sharedInstance.getConnection else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.playerName != nil && item.score != nil) {
            let insert = table.insert(playerName <- item.playerName!, score <- item.score!)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SqliteManager.sharedInstance.getConnection else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.highscoreId {
            let query = table.filter(highscoreId == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SqliteManager.sharedInstance.getConnection else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        let query = table.filter(highscoreId == id)
        let items = try DB.prepare(query)
        
        for item in items {
            return Highscore(
                highscoreId: item[highscoreId],
                score: item[score],
                playerName: item[playerName])
        }
        
        return nil
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SqliteManager.sharedInstance.getConnection else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        var result = [T]()
        let items = try DB.prepare(table)
        
        for item in items {
            result.append(Highscore(highscoreId: item[highscoreId], playerName: item[playerName], score: item[score]))
        }
        
        return result
    }
}