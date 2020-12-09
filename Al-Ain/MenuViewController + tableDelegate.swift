//
//  MenuTableDelegat.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import LUExpandableTableView
import Tabman

extension MenuViewController: LUExpandableTableViewDelegate  {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
        
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        
        var   taxonomy:Taxonomy = Taxonomy()
        print("//////////////\(indexPath.section)")
        //self.close(self.closeBtn)

      //  switch indexPath.section {
//        case 5:
//            if indexPath.row == (self.taxonmies.sections.count) {
//                openMore(TaxonomyType.SECTION, title:MenuViewController.taxonmyTitles[ indexPath.section])
//            }else{
//                taxonomy = (self.taxonmies.sections[indexPath.row]);
//
//            }
//            break
//
//        case 6 :
//            if indexPath.row == (self.taxonmies.pages.count) {
//                openMore(TaxonomyType.PAGE, title:MenuViewController.taxonmyTitles[ indexPath.section])
//
//            }else{
//                taxonomy = (self.taxonmies.pages[indexPath.row]);
//                taxonomy.type = .PAGE
//            }
//            break
            
      /*  case 2 :
            if indexPath.row == (self.taxonmies.countries.count) {
                openMore(TaxonomyType.COUNTRY, title:MenuViewController.taxonmyTitles[ indexPath.section])
                
            }else{
                taxonomy = (self.taxonmies.countries[indexPath.row]);
                taxonomy.type = .COUNTRY
                
            }
            break
            
        case 6 :
            if indexPath.row == (self.taxonmies.tags.count) {
                openMore(TaxonomyType.PAGE,  title:MenuViewController.taxonmyTitles[ indexPath.section])
            }else{
                taxonomy = (self.taxonmies.tags[indexPath.row]);
                   taxonomy.type = .PAGE
            }
            break
        default:
            if indexPath.row == (self.taxonmies.tags.count) {
                openMore(TaxonomyType.TAG, title:MenuViewController.taxonmyTitles[ indexPath.section])
            }else{
                taxonomy = (self.taxonmies.tags[indexPath.row]);
                taxonomy.type = .TAG
            }
            break
            
        }
        if taxonomy.id != nil{
           // drawer()?.close(to: .right)
            drawer()?.close(to: .right, animated: false, completion: nil)
            SectionFromMenu = false
            FromTypeSection = false
            AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: TabBaController.Shared!  )
        }*/
        
    }
    
    func openMore(_ type:TaxonomyType, title : String){
         drawer()?.close(to: .right)
        drawer()?.close(to: .left)

        let moreTaxonomiesViewController = RootViewController.shared?.storyboard?.instantiateViewController(withIdentifier: "MoreTaxonomiesViewController") as! MoreTaxonomiesViewController
        moreTaxonomiesViewController.taxonomyType = type
        moreTaxonomiesViewController.title = title
        moreTaxonomiesViewController.titleNav = title;
    RootViewController.shared?.navigationController?.pushViewController(moreTaxonomiesViewController, animated: true)
        
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        
        var   taxonomyType:TaxonomyType
        drawer()?.close(to: .left)

        switch section {
        case 0:
            RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
            RootViewController.shared?.scrollToPage(.at(index:  (RootViewController.shared?.viewControllers.count)! - 1), animated: false)
            RootViewController.shared?.tabBarController?.selectedIndex = 4
            taxonomyType = .HOME
           // self.dismiss(animated: true, completion: nil)
            drawer()?.close(to: .right)
            
            titleFromMenu = ""
            return
            
        case 1:
            titleFromMenu = ""

//راي
            RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
            RootViewController.shared?.tabBarController?.selectedIndex = 1
            drawer()?.close(to: .right)
            drawer()?.close(to: .left)

            return
                
             

            return
        case 2:
            
            titleFromMenu = ""

//swar
            RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
            RootViewController.shared?.tabBarController?.selectedIndex = 2
            MediaVC.sharedMedia?.scrollToPage(.at(index:   2), animated: false)

             
            drawer()?.close(to: .left)

            drawer()?.close(to: .right)
            return
                
            
                
        case 3:
            titleFromMenu = ""
            RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
            RootViewController.shared?.tabBarController?.selectedIndex = 2
            MediaVC.sharedMedia?.scrollToPage(.at(index:   1), animated: false)
//            taxonomyType = .VIDEO
            //self.dismiss(animated: true, completion: nil)
            drawer()?.close(to: .right)
            

            return
                
        case 4:
            titleFromMenu = ""

//swar
            RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
            RootViewController.shared?.tabBarController?.selectedIndex = 2
            MediaVC.sharedMedia?.scrollToPage(.at(index:   0), animated: false)

             
             
            drawer()?.close(to: .right)
            return
            
              case 5:
                titleFromMenu = ""

    //swar
                RootViewController.shared?.navigationController?.popToRootViewController(animated:  false)
                RootViewController.shared?.tabBarController?.selectedIndex = 3
                 
                drawer()?.close(to: .right)
                drawer()?.close(to: .left)

                return
            case 6:
                     
                        openMore(TaxonomyType.TAG, title:"هاشتاقات")

                       return
            case 7:
                openMore(TaxonomyType.COUNTRY, title:"البلدان")

               return
        case 8 :
            openMore(TaxonomyType.PAGE, title:"صفحات")

           return
                                 
        case 9 :
            drawer()?.close(to: .right)
            drawer()?.close(to: .left)

            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "Main", bundle: nil)
            
            let about = mainView.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            RootViewController.shared?.navigationController?.pushViewController(about, animated: true)
            return
                           
                
        default :
            sectionHeader.delegate?.expandableSectionHeader(sectionHeader, shouldExpandOrCollapseAtSection: section)
            
            return
            
        }
       
    }
    
    
    
}
