//
//  Notification.swift
//  Al-Ain
//
//  Created by Alex on 7/4/18.
//  Copyright © 2018 egygames. All rights reserved.
//

import Foundation
import RealmSwift


 @objcMembers class NotificationItems: Object {

    dynamic var body : String? = ""
    dynamic var title : String? = ""
    dynamic var article_id : String? = ""
    dynamic var img : String? = ""
   // dynamic var ClearCache = RealmOptional<Bool>()
    dynamic var notificationDate : Date?
//    dynamic var details : Detail?


    
    convenience init(body : String?,title : String?,article_id : String? ,img : String?,ClearCache : Bool?,notificationDate : Date) {
        self.init()
        self.body = body
        self.title = title
        self.article_id = article_id
        self.img = img
        //self.ClearCache.value = ClearCache
        self.notificationDate = notificationDate
    }

}
