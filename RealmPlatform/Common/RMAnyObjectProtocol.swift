//
//  RMAnyObjectProtocol.swift
//  RealmPlatform
//
//  Created by 이광용 on 21/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift

protocol RMAbstractObjectProtocol: AnyObject {}

protocol RMAnyObjectProtocol: AnyObject {
    associatedtype AbstractObject: RMAbstractObjectProtocol
    var typeName: String { get set }
    var primaryKey: String { get set }
    static var supportedClasses: [AbstractObject.Type] { get }}

extension RMAnyObjectProtocol where Self: Object, AbstractObject: Object {
    static var objectDictionary: [String: AbstractObject.Type] {
        var dictionary = [String: AbstractObject.Type]()
        supportedClasses.forEach {
            dictionary[String(describing: $0)] = $0
        }
        return dictionary
    }
    init(_ abstractObject: AbstractObject) {
        self.init()
        let abstractType = type(of: abstractObject)
        typeName = String(describing: abstractType)
        guard let primaryKeyName = abstractType.primaryKey() else {
            fatalError("`\(typeName)` does not define a primary key")
        }
        guard let primaryKeyValue = abstractObject.value(forKey: primaryKeyName) as? String else {
            fatalError("`\(typeName)`'s primary key `\(primaryKeyName)` is not a `String`")
        }
        primaryKey = primaryKeyValue
    }
    var value: AbstractObject {
        guard let type = Self.objectDictionary[typeName] else {
            fatalError("Unknown method `\(typeName)`")
        }
        do {
            guard let value = try Realm().object(ofType: type, forPrimaryKey: primaryKey) else {
                fatalError("Unknown method `\(typeName)`")
            }
            return value
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
