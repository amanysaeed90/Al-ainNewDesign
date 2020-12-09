//
//  Tags.swift
//
//  Created by Melad on 8/22/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm


class ListTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> Object? {
        let results = List<T>()
        if let objects = mapper.mapArray(JSONObject: value) {
            for object in objects {
                results.append(object)
            }
        }
        return results
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}
@objc public final class Taxonomy: Object , Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let name = "name"
        static let type = "type"
        static let color = "color"
        static let logo = "logo"
        
    }
    
    // MARK: Properties
     @objc dynamic public var id: String?
     @objc dynamic private var intId: Int = 0
     @objc dynamic public var name: String?
     @objc dynamic public var color:String?
     @objc dynamic public var logo:String?
     @objc dynamic public var taxType:String?
     dynamic public var type: TaxonomyType?
    
    override public class func primaryKey() -> String? {
        return "id"
    }

    public required init(map: Map) {
        super.init()
    }
    
    required public init() {
        super.init()
        self.type = .SECTION
        if let ID = self.id {
                   self.intId = Int(ID) ?? 0
               }
               else
               {
                    self.intId = 0
               }
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
    public  init(id: String , name : String , color :String , logo :String , type:TaxonomyType) {
        super.init()
        self.id = id
        self.name = name
        self.color = color
        self.logo = logo
        self.type = type
        self.taxType = "category"
        if let ID = self.id {
            self.intId = Int(ID) ?? 0
        }
        else
        {
             self.intId = 0
        }
    }
    
//    required convenience public init?(map: Map) { self.init() }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        intId <- (map[SerializationKeys.id])
        if(intId == -1 || intId == 0){
            id <- (map[SerializationKeys.id])
        }else{
            id = String(intId)
            
        }
        name <- map[SerializationKeys.name]
        type <- map[SerializationKeys.type]
        color <- map[SerializationKeys.color]
        logo <- map[SerializationKeys.logo]
        
           
        
    }
    
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        super.init()
        self.id = (aDecoder.decodeObject(forKey: SerializationKeys.id) as? String)!
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.color = aDecoder.decodeObject(forKey: SerializationKeys.color) as? String
        self.logo = aDecoder.decodeObject(forKey: SerializationKeys.logo) as? String
         let strType = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
        self.type = TaxonomyType(rawValue:strType! )!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(color, forKey: SerializationKeys.color)
        aCoder.encode(logo, forKey: SerializationKeys.logo)
        aCoder.encode(type?.rawValue, forKey:SerializationKeys.type )
    }
    
    
    
    /*
     taxonomies":[{"type":"category","name":"zz","id":"2123"},{"type":"category","name":"zz"}]}
     
     القيم المسموحة بالظبط هي
     
     countries
     
     page
     
     category
     tags لاكن لا ترجع محتويات الان
     
     author
     ​
     
     مسار api
     */
    
    
}
