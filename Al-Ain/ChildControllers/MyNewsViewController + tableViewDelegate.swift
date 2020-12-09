//
//  HomePageViewController + tableViewDelegate.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit

extension MyNewsViewController :UITableViewDelegate{
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
       AppUtils.launchSingleArticleView (articleId:  articlesHits[indexPath.row]["objectID"] as! String ,controller: self)     
        
    }
    
    
    
    
   }
