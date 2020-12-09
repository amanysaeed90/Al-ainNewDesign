//
//  RootController + pageDataSource.swift
//  Al-Ain
//
//  Created by imac on 9/4/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Pageboy
import Localize_Swift
import Foundation
import Tabman

extension RootViewController: PageboyViewControllerDataSource, TMBarDataSource {
    /// The number of view controllers to display.
    ///
    /// - Parameter pageboyViewController: The Page view controller.
    /// - Returns: The total number of view controllers to display.

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        
        let homeView  = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        let FeaturedVC = self.storyboard?.instantiateViewController(withIdentifier: "TrendVC") as! TrendVC
        let taxonomyFeatured = Taxonomy()
        taxonomyFeatured.type = .Featured
        FeaturedVC.taxonomy = taxonomyFeatured
        let TrendVC = self.storyboard?.instantiateViewController(withIdentifier: "TrendVC") as! TrendVC
        let taxonomytrend = Taxonomy()
        taxonomytrend.type = .Trend
        TrendVC.taxonomy = taxonomytrend

        let TrendVCcorona = self.storyboard?.instantiateViewController(withIdentifier: "CoronaVC") as! CoronaVC
        let taxonomytrendcorona = Taxonomy()


        viewControllers.append(TrendVC)
        viewControllers.append(TrendVCcorona)
        viewControllers.append(FeaturedVC) // كروناFeaturedVC
        viewControllers.append(homeView)
        
        
       return  viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        var title = ""
        if (index == 0)
        {
            title  = "Trend".localized()

        }
        if (index == 1)
        {
            title  =  "Corona".localized()

        }
        if (index == 2)
        {
            title  = "LatestNews".localized()

        }
        if (index == 3)
        {
            title  = "HomeTab".localized()

        }
        return TMBarItem(title: title)
    }

    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        if(taxonomiesResponse != nil) {
//            return  Page.at(index: (homeTaxonomies.count - 1))
//        }
    
//        if Localize.currentLanguage() == "en" {
//
          // return  Page.at(index: 3)
//
//        }
//        else {
//        return  Page.at(index: ( 3))
//        }
//
        return nil
        
    }
    
    
    
}
