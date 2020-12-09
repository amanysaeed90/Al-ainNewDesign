//
//  MenuTableDataSource.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import  LUExpandableTableView
import Localize_Swift

// MARK: - LUExpandableTableViewDataSource
extension MenuViewController : LUExpandableTableViewDataSource {
    
    
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        print(MenuViewController.taxonmyTitles.count)
        return MenuViewController.taxonmyTitles.count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        print(self.taxonmies)
        if  self.taxonmies != nil
        {
            switch section {
            case 0, 1 , 3 , 4,5:
                return 0
        
            case 6 :
                print((self.taxonmies.pages.count) + 1)
                return (self.taxonmies.pages.count) + 1
            case 7 :
                print((self.taxonmies.tags.count) + 1)
                return (self.taxonmies.tags.count) + 1
            case 2 :
                return (self.taxonmies.countries.count)  + 1
            default :
                return 0
                
            }
        }
        return 0
        
        
        
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MenuItemCell else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        var title = "More".localized()
        var textColor = Colors.accentColor
        var tax:Taxonomy! = nil
        switch indexPath.section {
//        case 5:
//            if indexPath.row < (self.taxonmies.sections.count) {
//                title = (self.taxonmies.sections[indexPath.row]).name!
//                tax = (self.taxonmies.sections[indexPath.row])
//                textColor = .white
//            }
//            break
            
        case 6 :
            if indexPath.row < (self.taxonmies.pages.count) {
                title = (self.taxonmies.pages[indexPath.row]).name!
                tax = (self.taxonmies.pages[indexPath.row])
                textColor = .white
            }
            break
            
        case 2 :
            if indexPath.row < (self.taxonmies.countries.count) {
                title = (self.taxonmies.countries[indexPath.row]).name!
                tax = (self.taxonmies.countries[indexPath.row])
                
                textColor = .white
            }
            break
            
        case 7 :
            if indexPath.row < (self.taxonmies.tags.count) {
                title = (self.taxonmies.tags[indexPath.row]).name!
                tax = (self.taxonmies.tags[indexPath.row])
                textColor = .white
            }
            break
            
        default :
            title = ""
            break
        }
        
        cell.label.text = title
        if tax != nil  && !MyTaxonomy.isTaxonomyInMyTaxonomies(tax){
            cell.tax = tax
           // cell.addBtn.isHidden = false
        }else{
          //  cell.addBtn.isHidden = true
        }
    cell.label.textColor = UIColor.black
        return cell
    }
    

    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? MenuItemHeader else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }
        
        
        if (section == 2 || section == 6 || section == 7 ){
            sectionHeader.expandCollapseButton.isHidden = false
        }  else {
            sectionHeader.expandCollapseButton.isHidden = true
            
        }
        print (MenuViewController.taxonmyTitles[section])
        sectionHeader.label.text = MenuViewController.taxonmyTitles[section]
        
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            sectionHeader.label.textAlignment = .left
        }
        else
        {
            // fa // ar
            sectionHeader.label.textAlignment = .right
        }
        
        
       

        return sectionHeader
    }
    
    
    
}
