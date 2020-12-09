//
//  Info.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Info: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let id = "id"
    static let slug = "slug"
    static let type = "type"
  }

  // MARK: Properties
  public var title: String?
  public var id: Int?
  public var slug: String?
  public var type: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    title <- map[SerializationKeys.title]
    id <- map[SerializationKeys.id]
    slug <- map[SerializationKeys.slug]
    type <- map[SerializationKeys.type]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = slug { dictionary[SerializationKeys.slug] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    return dictionary
  }

}
