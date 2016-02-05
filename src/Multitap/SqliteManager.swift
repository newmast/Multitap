//
//  SqliteManager.swift
//  Multitap
//
//  Created by Nick on 2/4/16.
//  Copyright © 2016 Nick. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: ErrorType {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

@objc class SqliteManager: NSObject {
    static let sharedInstance = SqliteManager()
    let getConnection: Connection?
    
    private override init() {
        
        var path = "Multitap.sqlite"
        
        if let dirs: [NSString] =
            NSSearchPathForDirectoriesInDomains(
                NSSearchPathDirectory.DocumentDirectory,
                NSSearchPathDomainMask.AllDomainsMask, true) as [NSString]
        {
            path = dirs[0].stringByAppendingPathComponent(path);
        }
        
        do {
            getConnection = try Connection(path)
        } catch _ {
            getConnection = nil
        }
    }
    
    func createTables() throws{
        do {
            try HighscoreDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
        
    } 
}