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
    //Your own properties
    var id: Int = 0
    var name: String = ""    // Optional if it would be nil in some WCDB selection
    var age: Int? = nil // Optional if it would be nil in some WCDB selection
    var ownerName: String? = nil
    var ownerID: String? = nil

    enum CodingKeys: String, CodingTableKey {
        typealias Root = Pet
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        //List the properties which should be bound to table
        case id
        case name
        case age
        case ownerName
        case ownerID



        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .id: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                .name: ColumnConstraintBinding(isNotNull: true, isUnique: true),
            ]
        }

        //Index bindings. It is optional.
        static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
            return [
                "_index": IndexBinding(indexesBy: CodingKeys.name)
            ]
        }

        //Table constraints for multi-primary, multi-unique and so on. It is optional.
        //static var tableConstraintBindings: [TableConstraintBinding.Name: TableConstraintBinding]? {
        //    return [
        //        "MultiPrimaryConstraint": MultiPrimaryBinding(indexesBy: variable2.asIndex(orderBy: .descending), variable3.primaryKeyPart2)
        //    ]
        //}

        //Virtual table binding for FTS and so on. It is optional.
        //static var virtualTableBinding: VirtualTableBinding? {
        //    return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .WCDB))
        //}
    }

    //Properties below are needed only the primary key is auto-incremental
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 1
}
