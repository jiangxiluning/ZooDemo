//
//  PetsDB.swift
//  zoo
//
//  Created by luning on 2018/12/18.
//  Copyright © 2018 luning. All rights reserved.
//

import Foundation
import WCDBSwift


class PetsDataSource {
    
    // Mark: Properties
    static let db = PetsDataSource()
    private let innerDB: Database
    private let tableName = "Pets"


    private init(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dbPath = paths[0] + "/data.db"
        self.innerDB = Database(withPath: dbPath)
        
        let isTableExisting = try! self.innerDB.isTableExists(self.tableName)
        
        if !isTableExisting {
            do {
                try self.innerDB.create(table: self.tableName, of: Pet.self)
            } catch let error{
                print("create table error: \(error)")
            }
        }
    }
    
    
    func addPet(name: String, age: Int? = nil, ownerName: String? = nil, ownerID: String? = nil) -> Bool {
        do {
            try self.innerDB.run(transaction: { () -> Void in
                let pet = Pet()
                pet.name = name
                pet.age = age
                pet.ownerName = ownerName
                pet.ownerID = ownerID
                try self.innerDB.insert(objects: pet, intoTable: self.tableName)
            })
            return true
        } catch let error {
            print("blocked transaction error: \(error)")
            return false
        }
    }
    
    func findPetByName(name: String) -> Pet? {
        do {
            let pet: Pet? = try self.innerDB.getObject(fromTable: self.tableName, where: Pet.Properties.name == name)
            return pet
        }catch let error{
            print("\(error)")
            return nil
        }
    }
    
    func cleanUp() {
        do {
            try self.innerDB.close(onClosed: {
                try self.innerDB.removeFiles()
            })
        } catch let error {
            print("move file error: \(error)")
        }
    }
}
