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
    
    
    func addPet(name: String, category: Pet.Category, age: Int? = nil, gender: Bool = true, ownerName: String? = nil, ownerID: String? = nil, feature: Data? = nil, image: Data? = nil) throws {
            try self.innerDB.run(transaction: { () -> Void in
                let pet = Pet()
                pet.name = name
                pet.category = category.rawValue
                pet.age = age
                pet.gender = gender
                pet.ownerName = ownerName
                pet.ownerID = ownerID
                pet.feature = feature
                pet.image = image
                try self.innerDB.insert(objects: pet, intoTable: self.tableName)
            })
    }
    
    func findPetByNameAndCategory(name: String, category: Pet.Category) -> Pet? {
        do {
            let pet: Pet? = try self.innerDB.getObject(fromTable: self.tableName, where: Pet.Properties.name == name && Pet.Properties.category == category.rawValue)
            return pet
        }catch let error{
            print("\(error)")
            return nil
        }
    }
    
    func findPetByID(_ id: Int) -> Pet? {
        do {
            let pet: Pet? = try self.innerDB.getObject(fromTable: self.tableName, where: Pet.Properties.id == id)
            return pet
        }catch let error{
            print("\(error)")
            return nil
        }
    }
    
    func getAllPetSIDs() -> [Int]? {

        do {
            let ids = try self.innerDB.getColumn(on: Pet.Properties.id, fromTable: tableName)
            if ids.count == 0
            {
                return nil
            }else
            {
                return (0..<ids.count).map({Int(ids[$0].int32Value)})
            }
            
        } catch let error {
            print("select one value error: \(error)")
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
