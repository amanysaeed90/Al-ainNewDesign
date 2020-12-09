//
//  Info.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public final class Info: Object , Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let id = "id"
   }

  // MARK: Properties
  @objc dynamic public var title: String?
  @objc dynamic public var id: String?
  @objc dynamic public var intId: Int = -1
    
    override public class func primaryKey() -> String? {
        return "id"
    }
    
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
    intId <- (map[SerializationKeys.id])
    if(intId != -1){
        id = String(intId)
    }else{
        id <- (map[SerializationKeys.id])
    }
    title <- map[SerializationKeys.title]
    

  }
    


  
}
