//
//  SavedArticele.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/13/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import RealmSwift
import Realm

public  class SavedArticle:Object {
    
    // MARK: Properties
    //    var MyTaxonomy = Taxonomy? //[Taxonomy]?
    //    var MyTaxonomyArray : Taxonomy?
            @objc dynamic  var SavedArticel:Article?
            @objc dynamic var id = "0"

    //
        override public static func primaryKey() -> String? {
                return "id"
            }
         
         // MARK: ObjectMapper Initializers
         /// Map a JSON object to this class using ObjectMapper.
         ///
         /// - parameter map: A mapping from ObjectMapper.
         public  init?(Art: Article){
             super.init()
                self.id = Art.id!
                self.SavedArticel? = Art
      
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
