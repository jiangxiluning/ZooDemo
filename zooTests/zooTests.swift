//
//  zooTests.swift
//  zooTests
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import XCTest
@testable import zoo

class zooTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let db = PetsDataSource.db
        db.cleanUp()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let db = PetsDataSource.db
        do{
            try db.addPet(name: "john", category: Pet.Category.dog)
            XCTAssert(true)
        }
        catch let e{
            print("\(e)")
            XCTAssert(false)
        }
        if let pet = db.findPetByNameAndCategory(name: "john", category: Pet.Category.dog) {
            XCTAssert(true)
            guard let category = Pet.Category(rawValue: pet.category!) else {
                print("something wrong with category.")
                XCTAssert(false)
                return
            }
            print("Pet Name: \(pet.name) Category: \(category)")
        }
        else{
            XCTAssert(false)
        }
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
