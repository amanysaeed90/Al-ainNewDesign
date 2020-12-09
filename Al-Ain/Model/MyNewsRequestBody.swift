//
//  MyNewsRequestBody.swift
//  Al-Ain
//
//  Created by imac on 9/19/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public final class MyNewsRequestBody: Object , Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let taxonomies = "taxonomies"
        
    }
    @objc dynamic public var id: String?

    // MARK: Properties
//    public var taxonomies: [Taxonomy]?

    public var taxonomiesArray: [Taxonomy] = []
    public var taxonomies = List<Taxonomy>()
  
    public required init(map: Map) {
        super.init()
    }
    
    required public init() {
        super.init()
    }
    override public class func primaryKey() -> String? {
        return "id"
    }
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    public override init(value: Any) {
        super.init(value: value)
    }
    
    //required convenience public init?(map: Map) { self.init() }
    
    
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        var countries: [Taxonomy]?
           taxonomies <- map[SerializationKeys.taxonomies]
           if let countries = countries {
               for countrie in countries {
                   id = countrie.id
                   self.taxonomiesArray.append(countrie)
               }
           }
        
    }
    
    
}
