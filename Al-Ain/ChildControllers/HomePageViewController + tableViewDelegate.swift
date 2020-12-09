//
//  HomePageViewController + tableViewDelegate.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation

import RealmSwift
import UIKit
extension HomePageViewController : UITableViewDelegate {
    
    func Gettaxnomy (title: String) -> Taxonomy {
                               
            let realm = try! Realm()
            let taxResult = realm.objects(Taxonomy.self).filter("name == %@", title)
            return taxResult.first!
        
         }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if (indexPath.section != 0  && indexPath.row == totalRows-1)
        {
            let array = Array(homeResponse.featuredInSection)
            let sectiontext = array[indexPath.section-1].info!.title
            let tax = self.Gettaxnomy(title: sectiontext!)
            FromTypeSection = false
            AppUtils.launchSectionViewController(taxonomy: tax, controller: self)
        }
        else
        {
        let articles = self.getArticles(section: indexPath.section)
        
        if(articles[indexPath.row].nodeType == Article.BANNER_ARTICLE_TYPE ){
            
            let about = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            about.navigatToURL   =  URLRequest(url: URL(string: articles[indexPath.row].fullurl!)!)
            self.navigationController?.pushViewController(about, animated: true)
            
            return
        }
        AppUtils.launchArticlesPagerController(articles: articles,  index : indexPath.row, controller: self ,title: articles[indexPath.row].sectionName!)
        }
        
    }
    
    
    
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
//        UIView.animate(withDuration: 0.2, animations: {
//            cell.contentView.alpha = 1.0
//        })
      
    }
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scriolling .. ")
        self.tableView.hideAllToasts()
        self.tableView.clearToastQueue()
    }
 
  
    
}
