//
//  AppUtils.swift
//  Al-Ain
//
//  Created by imac on 9/2/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import SwiftOverlays
import Toast_Swift
import Tabman

class AppUtils {
    
   static func showToast(uView: UIView, msg: String, position: ToastPosition) {
        var style = ToastStyle()
        style.messageAlignment = .right
        uView.makeToast(msg, duration: 3.0, position: position, style: style)
    }
    
    
    
    static func  launchArticlesPagerController (articles:[Article],index: Int, controller : UIViewController,title:String) {
        
        
        let articlesDetailsPager = controller.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsPagerController") as! ArticleDetailsPagerController
        articlesDetailsPager.articles = articles
        articlesDetailsPager.selectedPageIndex = index
        articlesDetailsPager.selectedIndex =  index
        if title != ""{
            articlesDetailsPager.title = title
        }else{
            articlesDetailsPager.title = articles[index].sectionName ?? ""
            
        }
        
        controller.navigationController?.pushViewController(articlesDetailsPager, animated: true)
    }




    static func  launchSingleArticleView (articleId:String , controller : UIViewController) {
        
        
        let articleController = controller.storyboard?.instantiateViewController(withIdentifier: "ArticleController") as! ArticleController
        articleController.articleId = articleId
        articleController.title = controller.title
        controller.navigationController?.pushViewController(articleController, animated: true)
    }

    static func  launchSingleArticleViewFromSearch (articleId:String ,Article :Article, controller : UIViewController) {
          
          
          let articleController = controller.storyboard?.instantiateViewController(withIdentifier: "ArticleController") as! ArticleController
          articleController.articleId = articleId
          articleController.article = Article
          articleController.title = controller.title
          controller.navigationController?.pushViewController(articleController, animated: true)
      }
    
    static func showErrorView(_ viewController:UIViewController  , retryHandler: Selector)
    {
     SwiftOverlays.removeAllBlockingOverlays()
        SwiftOverlays.removeAllOverlaysFromView(viewController.view)
        let errorView =  SwiftOverlays.showGenericOverlay(viewController.view, text: APIManager.networkConnectionError, accessoryView: UIImageView(image:UIImage.fontAwesomeIcon(name: .refresh, textColor:.white ,size: CGSize(width: 50, height: 50))), horizontalLayout: false)
     
        let tap = UITapGestureRecognizer(target: viewController, action: retryHandler)
        errorView.isUserInteractionEnabled = true
        errorView.addGestureRecognizer(tap)

        
    }
    
    static func showWait(_ view:UIView ){
      //  SwiftOverlays.removeAllOverlaysFromView(view)
        // SwiftOverlays.showCenteredWaitOverlayWithText(view,text: "جار التحميل")
    }
    
    static func removeWait(_ view:UIView ){
        SwiftOverlays.removeAllOverlaysFromView(view)
    }
    
    
    static func launchSectionViewController( taxonomy:Taxonomy!, controller : UIViewController ){
        
        
        let sectionController = controller.storyboard?.instantiateViewController(withIdentifier: "SectionController") as!  SectionController
        
        sectionController.setTaxonomy(taxonomy: taxonomy)
        sectionController.launchedAsStandAlone = true
        FromMedia = false
        // flag from menu or not
        if (SectionFromMenu == true){
        controller.navigationController?.pushViewController(sectionController, animated:false)
        }
        else
        {
        controller.navigationController?.pushViewController(sectionController, animated:true)

        }
        
        
    }
    static func launchSectionViewControllerOpenion( taxonomy:Taxonomy!, controller : UIViewController ){
        
        
        let sectionController = controller.storyboard?.instantiateViewController(withIdentifier: "SectionController") as!  SectionController
         FromMedia = false
        sectionController.setTaxonomy(taxonomy: taxonomy)
        sectionController.launchedAsStandAlone = true
        sectionController.autherCell = true
        sectionController.OpenionArticleID = Int(taxonomy.id ?? "0") ?? 0
        controller.navigationController?.pushViewController(sectionController, animated:true)
        
    }



    static func  getStringFromBase64(input:String)->String{
        
        if  let decodedData = Data(base64Encoded: input) {
        return  String(data: decodedData, encoding: .utf8)!
        }
        else
        {
            return ""
            
        }

    }

    static func extractImgUrlsFromString(input:String)->[String]{
        //<img[^>]+src="([^">]+)"
               return input.capturedGroups(withRegex: "<img[^>]+src=\"([^\">]+)\"")
            
        }
}
var spinnerView : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
       // let spinnerView = loading()
        spinnerView = Loader().loadViewFromNib()
        
//        let spinnerView = Bundle.main.loadNibNamed("Loader", owner: nil, options: nil)![0] as! UIView
      
        DispatchQueue.main.async {
            onView.addSubview(spinnerView!)
            spinnerView!.tag = 29806
            spinnerView!.bringSubview(toFront: onView)
            spinnerView!.translatesAutoresizingMaskIntoConstraints = false
            spinnerView!.topAnchor.constraint(equalTo: onView.topAnchor).isActive = true
            spinnerView!.leadingAnchor.constraint(equalTo: onView.leadingAnchor).isActive = true
            spinnerView!.bottomAnchor.constraint(equalTo: onView.bottomAnchor).isActive = true
            spinnerView!.trailingAnchor.constraint(equalTo: onView.trailingAnchor).isActive = true
            
        }
        
      //  vSpinner = spinnerView
    }
        func showSpinnerClear(onView : UIView) {
            spinnerView = Loader().loadViewFromNib()
            DispatchQueue.main.async {
                spinnerView?.backgroundColor = UIColor.clear
                onView.addSubview(spinnerView!)
                spinnerView!.tag = 29806
                spinnerView!.bringSubview(toFront: onView)
                spinnerView!.translatesAutoresizingMaskIntoConstraints = false
                spinnerView!.topAnchor.constraint(equalTo: onView.topAnchor).isActive = true
                spinnerView!.leadingAnchor.constraint(equalTo: onView.leadingAnchor).isActive = true
                spinnerView!.bottomAnchor.constraint(equalTo: onView.bottomAnchor).isActive = true
                spinnerView!.trailingAnchor.constraint(equalTo: onView.trailingAnchor).isActive = true
            }
        }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            if let viewWithTag = self.view.viewWithTag(29806) {
                viewWithTag.removeFromSuperview()
            }else{
            }
           // spinnerView?.removeAllSubviews()
            spinnerView?.removeFromSuperview()
//            vSpinner?.removeFromSuperview()
            //spinnerView? = nil
        }
    }
}
