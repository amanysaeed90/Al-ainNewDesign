//
//  ArticleObject.swift
//  Al-Ain
//
//  Created by amany elhadary
//  Copyright © 2018 egygames. All rights reserved.
//

import Foundation
import RealmSwift

 @objcMembers class ArticleObject : Object {
    
    @objc dynamic var mainImg :home = ""
    @objc dynamic var titleImg :String = ""
    @objc dynamic var sectionName :String = ""
   // var countries = List<TaxonomyObject>()
     var featureInSection: Int = 0
     @objc dynamic var fullurl: String  = ""
     @objc dynamic var nodeType: String = ""
     @objc dynamic var pageName: String = ""
     @objc dynamic var details: String = ""
     @objc dynamic var thumbImg: String = ""
      //var tags = List<TaxonomyObject>()
     var featureInHome: Int = 0
     @objc dynamic var pageId: String = ""
     @objc dynamic var descriptionValue: String = ""
    var updated: UInt64  = 0
     @objc dynamic var id: String = ""
      var created: UInt64 = 0
     @objc dynamic var subtitle: String = ""
     @objc dynamic var pageLogo: String = ""
     @objc dynamic var title: String = ""
     @objc dynamic var sectionId: String = ""
     @objc dynamic var autherName: String = ""
     @objc dynamic var videoCode: String = ""
     @objc dynamic var audioUrl: String = ""
     // var related = List<RelatedObject>()
     var convertedDtailsFromBase64 = false
    
}
