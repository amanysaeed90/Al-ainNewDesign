//
//  HomeController + tableViewDataSource.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation

import UIKit
extension MyNewsViewController :UITableViewDataSource{
    
    
    
    // MARK: - UITableViewDataSource
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesHits.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0  ){
            return UITableViewAutomaticDimension
        }else {
            
            return 100
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId:String
        
        if(indexPath.row == 0 ){
            cellId = featuredCellIdentifier
            
        }else {
            
            cellId = cellTypeIDs[Article.NEWS_ARTICLE_TYPE]!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
        cell?.configureWithData(articlesHits[indexPath.row])
       // cell?.contentView.alpha = 0

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        UIView.animate(withDuration: 0.2, animations: {
          //  cell.contentView.alpha = 1.0
        })
        
    }
    
  
}
