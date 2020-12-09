//
//  SectionController + tableViewDataSource.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
//import SkeletonView
import UIKit

extension SectionController:UITableViewDataSource  {
    
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 
    }
    //    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    //        var cellId:String
    //        if(indexPath.row == 0 ){
    //
    //            cellId = featuredCellIdentifier
    //
    //        }else {
    //
    //            cellId = "NormalPostCell"
    //        }
    //
    //        return cellId
    //    }
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if (articles.count != 0){
        if ( articles[indexPath.row].nodeType == Article.VIDEO_ARTICLE_TYPE)
        {
            
            return UITableViewAutomaticDimension
            
        }
        else {
            
            if(indexPath.row == 0 ){//}|| articles[indexPath.row].featureInSection != 0 ){
                // return UITableViewAutomaticDimension
                return 271
            }else {
                if (articles[indexPath.row].nodeType == Article.OPINION_ARTICLE_TYPE)
                {
                    return UITableViewAutomaticDimension
                }
                else {
                    return UITableViewAutomaticDimension
                }
            }
        }
    }
    
    //        else
    //        {
    //            if(indexPath.row == 0 ){//}|| articles[indexPath.row].featureInSection != 0 ){
    //                // return UITableViewAutomaticDimension
    //                return 271
    //            }else {
    //
    //                return 130
    //            }
    //
    //
    //        }
    //    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId:String
        
//        if(indexPath.row == 0 && articles[indexPath.row].featureInSection == 1 ){
//            if ( articles[indexPath.row].nodeType == Article.VIDEO_ARTICLE_TYPE)
//            {
//
//                cellId = cellTypeIDs[articles[indexPath.row].nodeType!]!
//            }
//            else
//            {
//                cellId = featuredCellIdentifier
//            }
//
//        }
        if(indexPath.row == 0  ){
                   
                        cellId = featuredCellIdentifier
                    
        
                }
        else {
            cellId = cellTypeIDs[articles[indexPath.row].nodeType!]!
            if (articles[indexPath.row].nodeType == Article.OPINION_ARTICLE_TYPE && autherCell == true){
                cellId = "autherOpenionPostCell"
            }
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
        cell?.parentViewController = self
        
        /*if (UIDevice.current.screenType == .iPhones_6_6s_7_8)
         {
         if let oldConstarint = cell?.photowidthRatio {
         let newConstraint = oldConstarint.constraintWithMultiplier(0.25)
         print("newConstraint = \(newConstraint)")
         DispatchQueue.main.async {
         cell?.removeConstraint(oldConstarint)
         cell?.addConstraint(newConstraint)
         self.view.layoutIfNeeded()
         cell?.photowidthRatio  = newConstraint
         }
         
         }
         
         }
         else if (UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus)
         {
         
         if let oldConstarint = cell?.photowidthRatio {
         let newConstraint = oldConstarint.constraintWithMultiplier(0.3)
         DispatchQueue.main.async {
         cell?.removeConstraint(oldConstarint)
         cell?.addConstraint(newConstraint)
         }
         view.layoutIfNeeded()
         cell?.photowidthRatio  = newConstraint
         }
         
         }*/
        
        
        
        
        let seconds = 0.0
        //DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        // cell?.hideanimation()
        if (articles[indexPath.row].nodeType == Article.OPINION_ARTICLE_TYPE && autherCell == true){
            
            cell?.configureWithOpenion(self.articles[indexPath.row])
            
        }
        else {
            cell?.configureWithData(self.articles[indexPath.row])
        }
        
        
        if (cellId == featuredCellIdentifier){
            cell?.title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        if (cellId == "OpenionPostCell")
        {
            DispatchQueue.main.async {
                
                
                print((cell?.photo.frame.size.width)!/2)
                cell?.photo.layer.masksToBounds = true
              //  cell?.photo.layer.cornerRadius = (cell?.photo?.frame.size.width)!/2
                cell?.layoutIfNeeded()
            }
        }
        
        
        // }
        
        
        // cell?.contentView.alpha = 0
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        var cellId:String
        cellId = cellTypeIDs[articles[indexPath.row].nodeType!]!
        if (cellId == "OpenionPostCell")
        {
            print("'lkefwh;ih;oiwfh;wefioh")
            //                print((cell.photo?.frame.size.width)!/2)
            //                cell.photo?.layer.cornerRadius = (cell.photo.frame.size.width)!/2
            //                cell.photo?.layer.masksToBounds = true
        }
        
        //        UIView.animate(withDuration: 0.2, animations: {
        //         //   cell.contentView.alpha = 1.0
        //
        //
        //        })
        //
        //
    }
    
    
    
}

