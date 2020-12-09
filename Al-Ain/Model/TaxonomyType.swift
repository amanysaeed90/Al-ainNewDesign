//
//  TaxonomyTypes.swift
//  Al-Ain
//
//  Created by imac on 8/22/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation

public enum TaxonomyType : String ,Codable{
    case SECTION = "category"
    case PAGE = "page"
    case TAG = "tags"
    case COUNTRY = "countries"
    case OPONION = "oponion"
    case HOME = "home"
    case MYNEWS = "mynews"
    case VIDEO = "videos"
    case INFOGRAPH = "infograph"
    case PHOTO = "photosnewsstory"
    case Trend = "trends"
    case Featured = "featured"
    case Corona = "Corona"
}
