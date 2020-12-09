//
//  Article.swift
//
//  Created by imac on 8/24/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm

public  class Article:Object, Mappable {
    
    static let VIDEO_ARTICLE_TYPE = "video"
    static let NEWS_ARTICLE_TYPE = "news"
    static let OPINION_ARTICLE_TYPE = "opinion"
    static let BANNER_ARTICLE_TYPE = "banner"
    
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let countries = "countries"
        static let Hits = "hits"

        static let mainImg = "main_img"
        static let imgTitle = "image_title"
        static let sectionName = "section_name"
        static let featureInSection = "feature_in_section"
        static let fullurl = "fullurl"
        static let nodeType = "node_type"
        static let pageName = "page_name"
        static let details = "details"
        static let thumbImg = "thumb_img"
        static let tags = "tags"
        static let featureInHome = "feature_in_home"
        static let pageId = "page_id"
        static let descriptionValue = "description"
        static let updated = "updated"
        static let id = "id"
        static let created = "created"
        static let subtitle = "subtitle"
        static let pageLogo = "page_logo"
        static let title = "title"
        static let sectionId = "section_id"
        static let  autherName = "author_name"
        static let  autherID = "author_id"
        static let  videoCode = "video_code"
         static let related = "related"
        static let audioUrl = "audio_url"
        
    }
    
    
    // MARK: Properties
    var countries = List<Taxonomy>() //[Taxonomy]?
    var countriesArray : [Taxonomy]?

    @objc dynamic public var mainImg: String?
    @objc dynamic public var titleImg: String?
    @objc dynamic public var sectionName: String?
    @objc dynamic var featureInSection: Int = 0
    @objc dynamic public var fullurl: String?
    @objc dynamic public var nodeType: String?
    @objc dynamic public var pageName: String?
    @objc dynamic var details: String?
    @objc dynamic  public var thumbImg: String?
    var tags = List<Taxonomy>()  //[Taxonomy]?
    var tagsArray : [Taxonomy]?
    @objc dynamic public var featureInHome: Int = 0
    @objc dynamic public var Hits: Int = 0

    @objc dynamic public var pageId: String?
    @objc dynamic public var descriptionValue: String?
    @objc dynamic public var updated:Int64 = 0 // UInt64 = 0
    @objc dynamic public var id: String?
    @objc dynamic public var created: Int64 = 0
    @objc dynamic public var subtitle: String?
    @objc dynamic public var pageLogo: String?
    @objc dynamic public var title: String?
    @objc dynamic public var sectionId: String?
    @objc dynamic public var autherName: String?
    @objc dynamic public var autherID:  Int = 0

    @objc dynamic public var videoCode: String?
    @objc dynamic public var audioUrl: String?
    var related = List<Related>()  //[Related] = []
    var relatedArray : [Related] = []
    @objc dynamic public var convertedDtailsFromBase64 = false
    
    
    override public class func primaryKey() -> String? {
        return "id"
    }
    
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public  init?(hit: Hits){
        super.init()

        title = hit.title
        sectionName = hit.category
        thumbImg = hit.image
        created = Int64( hit.created)
        updated = Int64( hit.created)
        id = hit.objectID
        
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
        
        
        var countries: [Taxonomy]?
        countries <- map[SerializationKeys.countries]
        if let countries = countries {
            for countrie in countries {
                  countrie.taxType = "countries"
                self.countries.append(countrie)
                
                //print(Array(self.countries))
            }
        }
      //  self.countries <- (map[SerializationKeys.countries], ListTransform<Taxonomy>())
        self.countriesArray = countries
        
        var tags: [Taxonomy]?
        tags <- map[SerializationKeys.tags]
        if let tags = tags {
            for tag in tags {
                tag.taxType = "tags"
                self.tags.append(tag)
            }
        }
        self.tagsArray = tags

        
        var relateds: [Related] = [Related]()
        relateds <- map[SerializationKeys.related]
            for related in relateds {
                self.related.append(related)
            }
        
        self.relatedArray = relateds
        //        related <- map[SerializationKeys.related]
       // countries <- map[SerializationKeys.countries]
        mainImg <- map[SerializationKeys.mainImg]
        titleImg <- map[SerializationKeys.imgTitle]
        sectionName <- map[SerializationKeys.sectionName]
        featureInSection <- map[SerializationKeys.featureInSection]
        fullurl <- map[SerializationKeys.fullurl]
        nodeType <- map[SerializationKeys.nodeType]
        pageName <- map[SerializationKeys.pageName]
        details <- map[SerializationKeys.details]
        thumbImg <- map[SerializationKeys.thumbImg]
        //tags <- map[SerializationKeys.tags]
        featureInHome <- map[SerializationKeys.featureInHome]
        pageId <- map[SerializationKeys.pageId]
        descriptionValue <- map[SerializationKeys.descriptionValue]
        updated <- map[SerializationKeys.updated]
        id <- map[SerializationKeys.id]
        created <- map[SerializationKeys.created]
        subtitle <- map[SerializationKeys.subtitle]
        pageLogo <- map[SerializationKeys.pageLogo]
        title <- map[SerializationKeys.title]
        sectionId <- map[SerializationKeys.sectionId]
        autherName <- map[SerializationKeys.autherName]
        autherID <- map[SerializationKeys.autherID]
        videoCode <- map[SerializationKeys.videoCode]
        audioUrl <- map[SerializationKeys.audioUrl]
        Hits <- map[SerializationKeys.Hits]
        
        
        

    }
    
    
    
  
    
    
}
