//
//  HomeResponse.swift
//
//  Created by imac on 8/30/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
import ObjectMapperAdditions

infix operator <-

/// Object of Realm's List type
public func <- <T: Mappable>( left: inout List<T>, right: Map) {
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}


public final class HomeResponse: Object , Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let featuredInHome = "featured_in_home"
    static let latestNews = "latest_news"
  //  static let banners = "banners"
    static let featuredInSection = "featured_in_section"
    static let videos = "videos"
  }

  // MARK: Properties
   var featuredInHome = List<Article>()//: [Article]?
   var latestNews = List<Article>() //: [Article]?
   var featuredInSection = List<FeaturedInSection>() //: [FeaturedInSection]?
   var videos = List<Article>()//: [Article]?
  @objc dynamic public var id: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
    
    
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
    
   
    
    
    var Articles: [Article]?
    Articles <- map[SerializationKeys.featuredInHome]
    if let Articles = Articles {
        for Article in Articles {
            self.featuredInHome.append(Article)
            id = Article.id
        }
    }
    featuredInHome <- (map[SerializationKeys.featuredInHome], ListTransform<Article>())

   
    
    var ArticleslatestNews: [Article]?
    ArticleslatestNews <- map[SerializationKeys.latestNews]
    if let ArticleslatestNews = ArticleslatestNews {
        for Article in ArticleslatestNews {
            self.latestNews.append(Article)
        }
    }
    var ArticlesfeaturedInSection: [FeaturedInSection]?
    ArticlesfeaturedInSection <- map[SerializationKeys.featuredInSection]
    if let ArticlesfeaturedInSection = ArticlesfeaturedInSection {
        for Article in ArticlesfeaturedInSection {
            self.featuredInSection.append(Article)
        }
    }
    
    var Articlesvideos: [Article]?
    Articlesvideos <- map[SerializationKeys.videos]
    if let Articlesvideos = Articlesvideos {
        for Article in Articlesvideos {
            self.videos.append(Article)
        }
    }
    
    
   
    
       //    //featuredInHome <- map[SerializationKeys.featuredInHome]
       //    latestNews <- map[SerializationKeys.latestNews]
      // //   banners <- map[SerializationKeys.banners]
     // featuredInSection <- map[SerializationKeys.featuredInSection]
     //  videos <- map[SerializationKeys.videos]
  }

  
}
