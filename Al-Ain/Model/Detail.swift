//
//  Detail.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/16/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

//
//    Detail.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Detail : NSObject, NSCoding, Mappable{

    var category : Int?
    var changed : Int?
    var comments : Int?
    var countries : String?
    var countriesCache : String?
    var created : Int?
    var descriptionField : String?
    var featureInHome : Int?
    var featureInMenu : Int?
    var featureInPage : Int?
    var featureInSection : Int?
    var featureLeftMenu : Int?
    var fullImage : String?
    var fullImageAlt : String?
    var fullImageTitle : String?
    var hashtag1 : Int?
    var hashtag2 : Int?
    var hashtag3 : Int?
    var hashtag4 : Int?
    var hashtag5 : Int?
    var hits : Int?
    var id : Int?
    var leftmenuImage : String?
    var menuImage : String?
    var newsTeaserImage : String?
    var pagecache : String?
    var pageid : Int?
    var relatedNewsIds : String?
    var relatedNewsImage : String?
    var sourceName : String?
    var sourceid : Int?
    var status : Int?
    var subtitle : String?
    var tags : String?
    var tagsCache : String?
    var title : String?
    var todayHits : Int?
    var type : Int?
    var urgent : Int?
    var urlSlug : String?
    var urlSlugHash : String?
    var userid : Int?
    var username : String?


    class func newInstance(map: Map) -> Mappable?{
        return Detail()
    }
    private override init(){}
    required init?(map: Map){}

    func mapping(map: Map)
    {
        category <- map["category"]
        changed <- map["changed"]
        comments <- map["comments"]
        countries <- map["countries"]
        countriesCache <- map["countries_cache"]
        created <- map["created"]
        descriptionField <- map["description"]
        featureInHome <- map["feature_in_home"]
        featureInMenu <- map["feature_in_menu"]
        featureInPage <- map["feature_in_page"]
        featureInSection <- map["feature_in_section"]
        featureLeftMenu <- map["feature_left_menu"]
        fullImage <- map["full_image"]
        fullImageAlt <- map["full_image_alt"]
        fullImageTitle <- map["full_image_title"]
        hashtag1 <- map["hashtag1"]
        hashtag2 <- map["hashtag2"]
        hashtag3 <- map["hashtag3"]
        hashtag4 <- map["hashtag4"]
        hashtag5 <- map["hashtag5"]
        hits <- map["hits"]
        id <- map["id"]
        leftmenuImage <- map["leftmenu_image"]
        menuImage <- map["menu_image"]
        newsTeaserImage <- map["news_teaser_image"]
        pagecache <- map["pagecache"]
        pageid <- map["pageid"]
        relatedNewsIds <- map["related_news_ids"]
        relatedNewsImage <- map["related_news_image"]
        sourceName <- map["source_name"]
        sourceid <- map["sourceid"]
        status <- map["status"]
        subtitle <- map["subtitle"]
        tags <- map["tags"]
        tagsCache <- map["tags_cache"]
        title <- map["title"]
        todayHits <- map["today_hits"]
        type <- map["type"]
        urgent <- map["urgent"]
        urlSlug <- map["url_slug"]
        urlSlugHash <- map["url_slug_hash"]
        userid <- map["userid"]
        username <- map["username"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         category = aDecoder.decodeObject(forKey: "category") as? Int
         changed = aDecoder.decodeObject(forKey: "changed") as? Int
         comments = aDecoder.decodeObject(forKey: "comments") as? Int
         countries = aDecoder.decodeObject(forKey: "countries") as? String
         countriesCache = aDecoder.decodeObject(forKey: "countries_cache") as? String
         created = aDecoder.decodeObject(forKey: "created") as? Int
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         featureInHome = aDecoder.decodeObject(forKey: "feature_in_home") as? Int
         featureInMenu = aDecoder.decodeObject(forKey: "feature_in_menu") as? Int
         featureInPage = aDecoder.decodeObject(forKey: "feature_in_page") as? Int
         featureInSection = aDecoder.decodeObject(forKey: "feature_in_section") as? Int
         featureLeftMenu = aDecoder.decodeObject(forKey: "feature_left_menu") as? Int
         fullImage = aDecoder.decodeObject(forKey: "full_image") as? String
         fullImageAlt = aDecoder.decodeObject(forKey: "full_image_alt") as? String
         fullImageTitle = aDecoder.decodeObject(forKey: "full_image_title") as? String
         hashtag1 = aDecoder.decodeObject(forKey: "hashtag1") as? Int
         hashtag2 = aDecoder.decodeObject(forKey: "hashtag2") as? Int
         hashtag3 = aDecoder.decodeObject(forKey: "hashtag3") as? Int
         hashtag4 = aDecoder.decodeObject(forKey: "hashtag4") as? Int
         hashtag5 = aDecoder.decodeObject(forKey: "hashtag5") as? Int
         hits = aDecoder.decodeObject(forKey: "hits") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         leftmenuImage = aDecoder.decodeObject(forKey: "leftmenu_image") as? String
         menuImage = aDecoder.decodeObject(forKey: "menu_image") as? String
         newsTeaserImage = aDecoder.decodeObject(forKey: "news_teaser_image") as? String
         pagecache = aDecoder.decodeObject(forKey: "pagecache") as? String
         pageid = aDecoder.decodeObject(forKey: "pageid") as? Int
         relatedNewsIds = aDecoder.decodeObject(forKey: "related_news_ids") as? String
         relatedNewsImage = aDecoder.decodeObject(forKey: "related_news_image") as? String
         sourceName = aDecoder.decodeObject(forKey: "source_name") as? String
         sourceid = aDecoder.decodeObject(forKey: "sourceid") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         subtitle = aDecoder.decodeObject(forKey: "subtitle") as? String
         tags = aDecoder.decodeObject(forKey: "tags") as? String
         tagsCache = aDecoder.decodeObject(forKey: "tags_cache") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         todayHits = aDecoder.decodeObject(forKey: "today_hits") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? Int
         urgent = aDecoder.decodeObject(forKey: "urgent") as? Int
         urlSlug = aDecoder.decodeObject(forKey: "url_slug") as? String
         urlSlugHash = aDecoder.decodeObject(forKey: "url_slug_hash") as? String
         userid = aDecoder.decodeObject(forKey: "userid") as? Int
         username = aDecoder.decodeObject(forKey: "username") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encodeConditionalObject(category, forKey: "category")
        }
        if changed != nil{
            aCoder.encodeConditionalObject(changed, forKey: "changed")
        }
        if comments != nil{
            aCoder.encodeConditionalObject(comments, forKey: "comments")
        }
        if countries != nil{
            aCoder.encodeConditionalObject(countries, forKey: "countries")
        }
        if countriesCache != nil{
            aCoder.encodeConditionalObject(countriesCache, forKey: "countries_cache")
        }
        if created != nil{
            aCoder.encodeConditionalObject(created, forKey: "created")
        }
        if descriptionField != nil{
            aCoder.encodeConditionalObject(descriptionField, forKey: "description")
        }
        if featureInHome != nil{
            aCoder.encodeConditionalObject(featureInHome, forKey: "feature_in_home")
        }
        if featureInMenu != nil{
            aCoder.encodeConditionalObject(featureInMenu, forKey: "feature_in_menu")
        }
        if featureInPage != nil{
            aCoder.encodeConditionalObject(featureInPage, forKey: "feature_in_page")
        }
        if featureInSection != nil{
            aCoder.encodeConditionalObject(featureInSection, forKey: "feature_in_section")
        }
        if featureLeftMenu != nil{
            aCoder.encodeConditionalObject(featureLeftMenu, forKey: "feature_left_menu")
        }
        if fullImage != nil{
            aCoder.encodeConditionalObject(fullImage, forKey: "full_image")
        }
        if fullImageAlt != nil{
            aCoder.encodeConditionalObject(fullImageAlt, forKey: "full_image_alt")
        }
        if fullImageTitle != nil{
            aCoder.encodeConditionalObject(fullImageTitle, forKey: "full_image_title")
        }
        if hashtag1 != nil{
            aCoder.encodeConditionalObject(hashtag1, forKey: "hashtag1")
        }
        if hashtag2 != nil{
            aCoder.encodeConditionalObject(hashtag2, forKey: "hashtag2")
        }
        if hashtag3 != nil{
            aCoder.encodeConditionalObject(hashtag3, forKey: "hashtag3")
        }
        if hashtag4 != nil{
            aCoder.encodeConditionalObject(hashtag4, forKey: "hashtag4")
        }
        if hashtag5 != nil{
            aCoder.encodeConditionalObject(hashtag5, forKey: "hashtag5")
        }
        if hits != nil{
            aCoder.encodeConditionalObject(hits, forKey: "hits")
        }
        if id != nil{
            aCoder.encodeConditionalObject(id, forKey: "id")
        }
        if leftmenuImage != nil{
            aCoder.encodeConditionalObject(leftmenuImage, forKey: "leftmenu_image")
        }
        if menuImage != nil{
            aCoder.encodeConditionalObject(menuImage, forKey: "menu_image")
        }
        if newsTeaserImage != nil{
            aCoder.encodeConditionalObject(newsTeaserImage, forKey: "news_teaser_image")
        }
        if pagecache != nil{
            aCoder.encodeConditionalObject(pagecache, forKey: "pagecache")
        }
        if pageid != nil{
            aCoder.encodeConditionalObject(pageid, forKey: "pageid")
        }
        if relatedNewsIds != nil{
            aCoder.encodeConditionalObject(relatedNewsIds, forKey: "related_news_ids")
        }
        if relatedNewsImage != nil{
            aCoder.encodeConditionalObject(relatedNewsImage, forKey: "related_news_image")
        }
        if sourceName != nil{
            aCoder.encodeConditionalObject(sourceName, forKey: "source_name")
        }
        if sourceid != nil{
            aCoder.encodeConditionalObject(sourceid, forKey: "sourceid")
        }
        if status != nil{
            aCoder.encodeConditionalObject(status, forKey: "status")
        }
        if subtitle != nil{
            aCoder.encodeConditionalObject(subtitle, forKey: "subtitle")
        }
        if tags != nil{
            aCoder.encodeConditionalObject(tags, forKey: "tags")
        }
        if tagsCache != nil{
            aCoder.encodeConditionalObject(tagsCache, forKey: "tags_cache")
        }
        if title != nil{
            aCoder.encodeConditionalObject(title, forKey: "title")
        }
        if todayHits != nil{
            aCoder.encodeConditionalObject(todayHits, forKey: "today_hits")
        }
        if type != nil{
            aCoder.encodeConditionalObject(type, forKey: "type")
        }
        if urgent != nil{
            aCoder.encodeConditionalObject(urgent, forKey: "urgent")
        }
        if urlSlug != nil{
            aCoder.encodeConditionalObject(urlSlug, forKey: "url_slug")
        }
        if urlSlugHash != nil{
            aCoder.encodeConditionalObject(urlSlugHash, forKey: "url_slug_hash")
        }
        if userid != nil{
            aCoder.encodeConditionalObject(userid, forKey: "userid")
        }
        if username != nil{
            aCoder.encodeConditionalObject(username, forKey: "username")
        }

    }

}
