//
//  MyTaxonomyies.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/1/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

public final class MyTaxonomyies: Object {
    // MARK: Properties
//    var MyTaxonomy = Taxonomy? //[Taxonomy]?
//    var MyTaxonomyArray : Taxonomy?
        @objc dynamic var Tax:Taxonomy?
        @objc dynamic var id = "0"
        @objc dynamic var type = "0"

//   
    override public static func primaryKey() -> String? {
            return "id"
        }
         // MARK: ObjectMapper Initializers
        /// Map a JSON object to this class using ObjectMapper.
       ///
      /// - parameter map: A mapping from ObjectMapper.
     public  init?(Tax: Taxonomy){
            super.init()
            self.id = Tax.id!
            self.Tax? = Tax
            self.type = Tax.type?.rawValue ?? ""
    }
    required public init() {
           super.init()
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
    
}
