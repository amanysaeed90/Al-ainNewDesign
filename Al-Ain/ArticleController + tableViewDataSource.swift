//
//  ArticleController + tableViewDataSource.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit

extension ArticleController :UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( !isDataDisplayed ){
            return 0
        }
        switch section {
        case  0:
            return 2
        case 2 :
            return 0 //taxonomies.count
        case 1 :
            return relatedArticles.count
            
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if (indexPath.row == 0)
            {return webViewHeight}
            else
            {return UITableViewAutomaticDimension }
            
        case 2 :
            return 0 // 45
            
        case 1 :
            return UITableViewAutomaticDimension
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if article == nil {
            return UITableViewCell()
        }
        let cellId:String = rowsCellsForSection[indexPath.section]
        
        switch indexPath.section {
        case 0:
            if (indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WebViewCell
                configureWebView( (cell?.webView)!)
                
                cell?.separatorInset = UIEdgeInsetsMake(0.0, (cell?.bounds.size.width)! , 0.0, 0.0);
                cell?.contentView.alpha = 0
                return cell!
            }
            else
            {
                let cell:hashtagCell = tableView.dequeueReusableCell(withIdentifier: "hashtagCell", for: indexPath) as! hashtagCell
                cell.collectionViewHashtags.contentMode = .right
                // cell.semanticContentAttribute = .forceLeftToRight
               // cell.collectionViewHashtags.transform = CGAffineTransform(scaleX: -1, y: 1)
                cell.VC = self
                
                cell.collectioviewConfigration()
                if (taxonomies.count > 0){
                    cell.items = taxonomies.map{($0.name ?? "")}
                    cell.taxonomies = taxonomies
                }
                
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TopicCell
            if let tax = taxonomies[indexPath.row].name {
                cell?.topicTitle.text =  tax
            }
            cell?.tax = taxonomies[indexPath.row]
            cell?.contentView.alpha = 0
            return cell!
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
            cell?.parentViewController = self
            cell?.configureWithData(relatedArticles[indexPath.row])
            cell?.tag = -1
            cell?.contentView.alpha = 0
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            
            if (indexPath.row == totalRows - 1){
                cell!.SeparatorLine.isHidden = true
            }else   {  cell!.SeparatorLine.isHidden = false
            }
            return cell!
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            if (relatedArticles.count > 0){
                return 47+15
            }
            else
            {
                return 0
            }
        default :
            return 47+15
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if article == nil {
            return UITableViewCell()
        }
        let cellId:String = sectionCells[section]
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableHeaderFooterView( withIdentifier:  cellId ) as? ArticleDetailsHeaderCell
            cell?.vc = self
            cell?.configureWithData(article,vc:self)
            
            return cell!
            
        case 2:
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellId) as? HeaderTitleCell
            cell?.title.text = "التصنيفات"
            cell?.sparetorUp.isHidden = true
            cell?.TopConstrain?.constant = 0
            
            cell?.TopConstarintcolorview?.constant = 20
            cell?.BottonConstarintcolorview?.constant = 20
            return cell!
            
        default:
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellId) as? HeaderTitleCell
            
            cell?.TopConstrain?.constant = 0
            cell?.sparetorUp?.isHidden = true
            cell?.TopConstarintcolorview?.constant = 20
            cell?.BottonConstarintcolorview?.constant = 20
            cell?.title.text = "RelatedNews".localized()
            
            return cell!
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
        UIView.animate(withDuration: 0.4, animations: {
            cell.contentView.alpha = 1.0
        })
        
        
        
    }
    
    
    
}
