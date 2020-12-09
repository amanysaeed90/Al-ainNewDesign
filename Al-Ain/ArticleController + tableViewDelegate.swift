//
//  ArticleController + tableViewDelegate.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation

import UIKit
extension ArticleController : UITableViewDelegate {
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            let sectionController = self.storyboard?.instantiateViewController(withIdentifier: "SectionController") as!  SectionController
            sectionController.setTaxonomy(taxonomy: taxonomies[indexPath.row])
            sectionController.launchedAsStandAlone = true
             FromTypeSection = true
            self.navigationController?.pushViewController(sectionController, animated:true)
            
        }else  if indexPath.section == 1 {
            
            AppUtils.launchSingleArticleView (articleId:  self.relatedArticles[indexPath.row].id! ,controller: self)
        }
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            for cell in tableView.visibleCells {
                guard let cell = cell as? WebViewCell else { continue }
                
                cell.webView.setNeedsLayout()
            }
        }
    }
    
    
    

}
