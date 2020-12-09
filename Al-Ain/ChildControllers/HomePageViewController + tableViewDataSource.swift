//
//  HomeController + tableViewDataSource.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import Localize_Swift
extension HomePageViewController : UITableViewDataSource{
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfTableViewSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  homeResponse == nil {
            return 0
        }
        switch section {
        case featuredInHome:
            return 1//(homeResponse.featuredInHome.count)
        case videosInHome:
            return 0//(homeResponse.videos.count)
        case latestInHome:
            return (homeResponse.latestNews.count)
            
            
        default:
            if homeResponse.featuredInSection[section - 1 ].nodes == nil {
                return 0
            }
            return (homeResponse.featuredInSection[section - 1 ].nodes.count)+1
            
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if(indexPath.row == 0 && indexPath.section == 0 )
        {
            return UITableViewAutomaticDimension
            
        }
        else if (indexPath.section != 0  && indexPath.row == totalRows-1)
        {
            return 47
        }
        
        else {
            //            if (self.PostsFullOrNot == "Not")
            //            {
            return UITableViewAutomaticDimension
            
            //            }
            //            else {
            //                if (article.nodeType == Article.OPINION_ARTICLE_TYPE)
            //                {   return 100}
            //                else {   return 300}
            //
            //            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return CGFloat.leastNonzeroMagnitude
        case 1:
            return 47
        default :
            return 47+15
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId:String
        // self.removeSpinner()
        tableView.register(UINib(nibName: PagerCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier:  PagerCellIdentifier)
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        // last cell in section (more cell)
        print("section --> \(indexPath.section)")
        print("Row --> \(indexPath.row)")
        print("totalRows --> \(totalRows)")
        
        
        
        if( (indexPath.row == 0 && indexPath.section == 0 ) ){
            let article = getArticle(indexPath: indexPath)
            
            cellId = PagerCellIdentifier
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PagerCell
            cell?.collectionView.register(UINib(nibName: "pagercontentCell", bundle: Bundle.main), forCellWithReuseIdentifier: "pagercontentCell")
            var ReturnedArticle : [Article] = [Article]()
            let List :List<Article> = homeResponse.featuredInHome
            for item in List
            {
                ReturnedArticle.append(item)
            }
            cell?.articel = ReturnedArticle
            //            cell?.collectionView.delegate = self
            cell?.collectionView.reloadData()
            cell?.collectionView.layoutIfNeeded()
            if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
                Localize.currentLanguage() == "am"{

                DispatchQueue.main.async {
                  //  cell?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
                    cell?.collectionView.setNeedsLayout() // **Without this effect wont be visible**
                    
                }
                
                cell?.PageController.set(progress: 0, animated: false)

            }
            
            else
            {
                // fa // ar
                DispatchQueue.main.async {
                    cell?.collectionView.scrollToItem(at: IndexPath(row: 3, section: 0), at: .centeredHorizontally, animated: false)
                    cell?.collectionView.setNeedsLayout() // **Without this effect wont be visible**

                }
                cell?.PageController.set(progress: 3, animated: false)

            }
            
            
            //            cell?.PageController
            
            cell?.parentViewController = self
            
            cell?.collectionView.sizeToFit()
            cell?.collectionView.layoutIfNeeded()
            cell?.collectionView.reloadData()
            cell?.collectionView.reloadData()
            
            //cell?.layoutIfNeeded()
            
            return cell!
            
        }
        else if (indexPath.section != 0  && indexPath.row == totalRows-1)
        {
            
            cellId = "MoreSectionNews"
            tableView.register(UINib(nibName: "MoreSectionNews", bundle: Bundle.main), forCellReuseIdentifier: "MoreSectionNews")
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MoreSectionNews
            return cell!
        }
        
        else {
            
            let article = getArticle(indexPath: indexPath)
            
            cellId = cellTypeIDs[article.nodeType!]!
            //            if cellId == "NormalPostCell" {
            //
            ////                if (self.PostsFullOrNot == "Not")
            ////                {
            //                    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
            //                    cell?.configureWithData(article)
            //                    cell?.contentView.alpha = 0
            //                    return cell!
            ////                }
            ////                else {
            ////                    cellId = featuredCellIdentifier
            ////
            ////                    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
            ////                    cell?.configureWithData(article)
            ////                    cell?.contentView.alpha = 0
            ////                    return cell!
            ////                }
            //            }
            //            else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
            
            let seconds = 0.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                cell?.hideanimation()
                cell?.configureWithData(article)
            }
            cell?.parentViewController = self
            cell?.time.isHidden = true
            //cell?.contentView.alpha = 0
            // cell?.layoutIfNeeded()
            if (indexPath.row == totalRows - 1){
                cell?.SeparatorLine?.isHidden = true
                
            }
            else
            {
                cell?.SeparatorLine?.isHidden = false
            }
            
            
            cell?.colorviewWidthConstraint?.constant = 0
            cell?.timeLeadingConstraint?.constant = 0
            cell?.SectionwidthConstraint?.constant = 0
            return cell!
            //            }
            
            
            
        }
        
        
        
        
        //return cell!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellId:String = "headerTitleCell"
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellId) as? HeaderTitleCell
        
        switch section {
        case featuredInHome:
            cell?.title.text = ""
            cell?.hideArrow();
            cell?.sectionInfo = nil
            
            cell?.TopConstrain.constant = 0
            cell?.sparetorUp.isHidden = true
            
            break
        case videosInHome:
            cell?.title.text = "فيديوهات"
            cell?.sectionInfo = nil
            cell?.isVideo = true
            cell?.hideArrow();
            cell?.TopConstrain.constant = 0
            
            break
        case latestInHome:
            cell?.title.text = "آخر الاخبار"
            cell?.sectionInfo = nil
            cell?.hideArrow();
            cell?.sparetorUp.isHidden = true

            cell?.TopConstrain.constant = 0
            
            break
        default:
            let array = Array(homeResponse.featuredInSection)
            cell?.title.text = array[section-1].info!.title
            
            cell?.sectionInfo = array[section-1].info
            cell?.showArrow();
            let SectionID  = array[section-1].info?.id
            let realm = try! Realm()
            let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: SectionID)?.color
            cell?.ColorView.backgroundColor = articelColor?.hexStringToUIColor()
            
            if  (section == 0)
            {
                cell?.TopConstrain.constant = 0
                cell?.TopConstarintcolorview.constant = 0
                cell?.BottonConstarintcolorview.constant = 0
                cell?.sparetorUp.isHidden = true
                
            }
            else if (section == 1)
            {
                cell?.TopConstrain.constant = 0
                cell?.TopConstarintcolorview.constant = 14
                cell?.BottonConstarintcolorview.constant = 14
                cell?.sparetorUp.isHidden = true
            }
            else {
                
                cell?.TopConstrain.constant = 20
                cell?.TopConstarintcolorview.constant = 12
                cell?.BottonConstarintcolorview.constant = 12
                cell?.sparetorUp.isHidden = false
                
            }
            
        }
        
        return cell!
        
        
    }
    
}
extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}
extension UITableView {
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}
