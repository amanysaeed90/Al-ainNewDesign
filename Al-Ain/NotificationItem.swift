//
//	NotificationItem.swift
//
//	Create by amany elhadary on 9/6/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class NotificationItem : NSObject, NSCoding, Mappable{

	var articleId : Int?
	var created :Int64?
	var displayOrder : Int?
	var id : Int?
	var showuntil : Int?
	var title : String?
	var updated : Int?
	var url : String?
    var details : Detail?



	class func newInstance(map: Map) -> Mappable?{
		return NotificationItem()
	}
    //override init(){}
    required init?(map: Map){}
    required override init() {
        
    }
    
    func mapping(map: Map)
	{
        articleId <- map["article_id"]
		created <- map["created"]
		displayOrder <- map["display_order"]
		id <- map["id"]
		showuntil <- map["showuntil"]
		title <- map["title"]
		updated <- map["updated"]
		url <- map["url"]
        details <- map["details"]
	}
    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         articleId = aDecoder.decodeObject(forKey: "article_id") as? Int
         created = aDecoder.decodeObject(forKey: "created") as? Int64  
         displayOrder = aDecoder.decodeObject(forKey: "display_order") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         showuntil = aDecoder.decodeObject(forKey: "showuntil") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         updated = aDecoder.decodeObject(forKey: "updated") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String
        details  = aDecoder.decodeObject(forKey: "details") as? Detail


	}
    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{   if details != nil{
            aCoder.encodeConditionalObject(articleId, forKey: "details")
        }
		if articleId != nil{
			aCoder.encodeConditionalObject(articleId, forKey: "article_id")
		}
		if created != nil{
			aCoder.encodeConditionalObject(created, forKey: "created")
		}
		if displayOrder != nil{
			aCoder.encodeConditionalObject(displayOrder, forKey: "display_order")
		}
		if id != nil{
			aCoder.encodeConditionalObject(id, forKey: "id")
		}
		if showuntil != nil{
			aCoder.encodeConditionalObject(showuntil, forKey: "showuntil")
		}
		if title != nil{
			aCoder.encodeConditionalObject(title, forKey: "title")
		}
		if updated != nil{
			aCoder.encodeConditionalObject(updated, forKey: "updated")
		}
		if url != nil{
			aCoder.encodeConditionalObject(url, forKey: "url")
		}

	}

    
    
}
