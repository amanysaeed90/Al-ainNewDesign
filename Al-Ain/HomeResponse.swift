//
//  HomeResponse.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class HomeResponse: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let featuredInHome = "featured_in_home"
    static let latestNews = "latest_news"
  //  static let banners = "banners"
    static let featuredInSection = "featured_in_section"
    static let videos = "videos"
  }

  // MARK: Properties
  public var featuredInHome: [Article]?
  public var latestNews: [LatestNews]?
 // public var banners: [Banners]?
  public var featuredInSection: [FeaturedInSection]?
  public var videos: [Article]?

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
    featuredInHome <- map[SerializationKeys.featuredInHome]
    latestNews <- map[SerializationKeys.latestNews]
 //   banners <- map[SerializationKeys.banners]
    featuredInSection <- map[SerializationKeys.featuredInSection]
    videos <- map[SerializationKeys.videos]
  }

  
}
