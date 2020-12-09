//
//  Related.swift
//
//  Created by imac on 9/3/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Related: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let img = "img"
    static let title = "title"
  }

  // MARK: Properties
  public var id: Int?
  public var img: String?
  public var title: String?

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
    id <- map[SerializationKeys.id]
    img <- map[SerializationKeys.img]
    title <- map[SerializationKeys.title]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = img { dictionary[SerializationKeys.img] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    return dictionary
  }

}
