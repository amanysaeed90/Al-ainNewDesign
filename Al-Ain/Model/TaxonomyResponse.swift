//
//  TaxonomyResponse.swift
//
//  Created by Melad on 8/22/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public final class TaxonomyResponse: Object , Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let countries = "countries"
    static let sections = "sections"
    static let tags = "hashtags"
    static let pages = "pages"
    
  }

  // MARK: Properties
  public var countries = List<Taxonomy>()//: [Taxonomy]?
  public var sections = List<Taxonomy>() //: [Taxonomy]?
  public var tags = List<Taxonomy>() //: [Taxonomy]?
  public var pages = List<Taxonomy>() // : [Taxonomy]?
  @objc dynamic public var id: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
    public required init(map: Map) {
        super.init()
    }
    override public class func primaryKey() -> String? {
        return "id"
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
    
    var countries: [Taxonomy]?
    countries <- map[SerializationKeys.countries]
    if let countries = countries {
        for countrie in countries {
            id = countrie.id
             countrie.taxType = "countries"
             countrie.type = .COUNTRY
             self.countries.append(countrie)
        }
    }
    var sections: [Taxonomy]?
    sections <- map[SerializationKeys.sections]
    if let sections = sections {
        for section in sections {
             id = section.id
             section.type = .SECTION
             section.taxType = "category"
             self.sections.append(section)
            
        }
    }
    var tags: [Taxonomy]?
    tags <- map[SerializationKeys.tags]
    if let tags = tags {
        for tag in tags {
            id = tag.id
            tag.type = .TAG
            tag.taxType = "tags"
            self.tags.append(tag)
          
        }
    }
    var pages: [Taxonomy]?
    pages <- map[SerializationKeys.pages]
    if let pages = pages {
        for page in pages {
              id = page.id
              page.type = .PAGE
              page.taxType = "page"
              self.pages.append(page)
           
        }
    }
  }

  
}
