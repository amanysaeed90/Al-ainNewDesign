
//
//  RootController + loadData.swift
//  Al-Ain
//
//  Created by imac on 9/4/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import SwiftOverlays
import RealmSwift
import Realm

extension RootViewController {
    
    
    
    
    
    
   /* func getTaxonmies(){
        
//        var items:[Item] = []
   self.dataSource = self
        
      //  let bar = TMBar.ButtonBar()
        
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
        bar.indicator.overscrollBehavior = .bounce
        bar.layout.interButtonSpacing = 20
        bar.layout.contentInset = UIEdgeInsets(top: 00.0, left: 10.0, bottom: 00.0, right: 10.0)
        bar.layout.alignment = .centerDistributed
        bar.buttons.customize{(button) in
            button.selectedTintColor = #colorLiteral(red: 0.03137254902, green: 0.4, blue: 0.3294117647, alpha: 1)
            button.tintColor = #colorLiteral(red: 0.7176470588, green: 0.7490196078, blue: 0.7411764706, alpha: 1)
            button.font =  Fonts.getFont(fontSize: 15)
        }
        addBar(bar, dataSource: self, at: .top)
    //    ShadowView.dropShadow(scale: true, color: #colorLiteral(red: 0.03137254902, green: 0.4, blue: 0.3294117647, alpha: 1))
        
        
        
        
         
//        let item = Item(title: "HomeTab".localized())
//        items.insert(item,at:0)
//
//        let item2 = Item(title: "LatestNews".localized())
//        items.insert(item2,at:0)
//
//        let item3 = Item(title: "Corona".localized())
//        items.insert(item3,at:0)
//
//
//        let item4 = Item(title: "Trend".localized())
//        items.insert(item4,at:0)
//
//        self.bar.items = items
//        self.reloadPages()
       
      
    }*/
    func addStaticTaxonomies(_ sections:List <Taxonomy> ) -> [Taxonomy]{
        var newSections:[Taxonomy] = []
       //newSections.append(contentsOf: sections)
     
        let home = Taxonomy()
        home.name = MenuViewController.taxonmyTitles[0]
        home.type  = .HOME
        newSections.insert(home, at: 0)
        
        
        
//        let video = Taxonomy()
//        video.name = MenuViewController.taxonmyTitles[3]
//        video.type  = .VIDEO
//        newSections.append(video )
        
//        let opinion = Taxonomy()
//        opinion.name = MenuViewController.taxonmyTitles[2]
//        opinion.type  = .OPONION
//        newSections.append(opinion )
//
        
        let infograph = Taxonomy()
        infograph.name = MenuViewController.taxonmyTitles[4]
        infograph.type  = .INFOGRAPH
        
        newSections.append(infograph )
        
        
        
        let myNews = Taxonomy()
        myNews.name = MenuViewController.taxonmyTitles[1]
        myNews.type  = .MYNEWS
        newSections.append(myNews)
        
        return newSections
    }
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(self.retry));
    }
    
    @objc func retry (_ sender: UIGestureRecognizer){
      //  SwiftOverlays.removeAllBlockingOverlays()
     //   self.getTaxonmies()
    }
    
    
}

