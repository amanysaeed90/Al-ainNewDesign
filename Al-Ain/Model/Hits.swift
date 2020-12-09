//
//  Hits.swift
//
//  Created by imac on 9/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public final class Hits:Object, Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let objectID = "objectID"
    static let category = "category"
    static let hits = "hits"
    static let created = "created"
    static let image = "image"
    static let title = "title"
    }

  // MARK: Properties
  @objc dynamic  var objectID: String?
  @objc dynamic  var category: String?
  @objc dynamic  var created: Int = 0
  @objc dynamic  var image: String?
  @objc dynamic  var title: String?
  
  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
    public required init(map: Map) {
        super.init()
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

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
     objectID <- map[SerializationKeys.objectID]
    category <- map[SerializationKeys.category]
    created <- map[SerializationKeys.created]
    image <- map[SerializationKeys.image]
    title <- map[SerializationKeys.title]
  }

 
}
