//
//  InfoObject.swift
//  Al-Ain
//
//  Created by amany elhadary on 12/23/18.
//  Copyright © 2018 egygames. All rights reserved.
//

import Foundation
import RealmSwift

class InfoObject : Object {
    
    @objc dynamic var id :String = ""
    @objc dynamic var title :String = ""
    
    
    
    convenience init(id : String?,title : String?) {
        self.init()
        self.id = id!
        self.title = title!
       
    }

    
}
