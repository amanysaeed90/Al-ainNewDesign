//
//  FeaturedInSection.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public final class FeaturedInSection: Object , Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let info = "info"
    static let nodes = "nodes"
  }

  // MARK: Properties
 @objc dynamic public var info : Info?
 @objc dynamic public var id : String?
 public var nodes = List<Article>() //: [Article]?
 public var nodesArray : [Article] = [Article]()

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMappe
    
    override public class func primaryKey() -> String? {
        return "id"
    }
    
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
    
    
 
    nodesArray <- map[SerializationKeys.nodes]
        for node in nodesArray {
           nodes.append(node)
        }
    
    

    info <- map[SerializationKeys.info]
    id = info?.id
   // nodes <- map[SerializationKeys.nodes]
    
    
    
  }

  }
