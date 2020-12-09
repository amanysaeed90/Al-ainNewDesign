//
//  FeaturedInSection.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class FeaturedInSection: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let info = "info"
    static let nodes = "nodes"
  }

  // MARK: Properties
  public var info: Info?
  public var nodes: [Article]?

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
    info <- map[SerializationKeys.info]
    nodes <- map[SerializationKeys.nodes]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = info { dictionary[SerializationKeys.info] = value.dictionaryRepresentation() }
    if let value = nodes { dictionary[SerializationKeys.nodes] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
