//
//  Pets.swift
//  zoo
//
//  Created by luning on 2018/12/17.
//  Copyright © 2018 luning. All rights reserved.
//

import Foundation
import WCDBSwift


class Pet: TableCodable {
    
    enum Category: Int, CaseIterable {
        case dog = 0, cat
        
        var description: String {
            switch self {
            case .dog:
                return "狗"
            case .cat:
                return "猫"
            default:
                return "其他"
            }
        }
    }
    
    enum Gender: String, CaseIterable {
        case male = "哥哥", female = "妹妹"
    }
 
    //Your own properties
    var id: Int = 0
    var name: String = ""    // Optional if it would be nil in some WCDB selection
    var category : Int? = nil
    var gender: Bool = true // true for male false for female
    var age: Int? = nil // Optional if it would be nil in some WCDB selection
    var ownerName: String? = nil
    var ownerID: String? = nil
    var feature: Data? = nil
    var image: Data? = nil

    enum CodingKeys: String, CodingTableKey {
        typealias Root = Pet
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        //List the properties which should be bound to table
        case id
        case name
        case age
        case ownerName
        case ownerID
        case category
        case feature
        case image



        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .id: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
            ]
        }

        //Index bindings. It is optional.
        static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
            return [
                "_name_category_index": IndexBinding(indexesBy: name, category),
                "_name_index": IndexBinding(indexesBy: name)
            ]
        }

        //Table constraints for multi-primary, multi-unique and so on. It is optional.
        static var tableConstraintBindings: [TableConstraintBinding.Name: TableConstraintBinding]? {
            return [
                "MultiUniqueConstraint": MultiUniqueBinding(indexesBy: name, category)
            ]
        }

        //Virtual table binding for FTS and so on. It is optional.
        //static var virtualTableBinding: VirtualTableBinding? {
        //    return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .WCDB))
        //}
    }

    //Properties below are needed only the primary key is auto-incremental
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 1
}
