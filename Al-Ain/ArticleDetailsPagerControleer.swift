//
//  ArticleDetailsPagerControleer.swift
//  Al-Ain
//
//  Created by imac on 8/25/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Pageboy
import RealmSwift
import Localize_Swift
class ArticleDetailsPagerController :  PageboyViewController, PageboyViewControllerDataSource {
    
//    PageboyViewControllerDelegate
    
    var articles:[Article] = []
    var articleViewControllers:[ArticleController] = []
    var selectedPageIndex:PageIndex!
    var selectedIndex:Int! = 0
    var titleNav : String = ""
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            self.setnavigationWhite_tintGray()
                 }
//       navigationController?.navigationBar.topItem?.title = titleNav

                 
        
//
//        if #available(iOS 13.0, *) {
//                                                      let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
//                                                      if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
//                                                      statusBar.backgroundColor = UIColor.white
//                                                      }
//
//        } else {
//              let statusBar = UIApplication.shared.value(forKeyPath:
//           "statusBarWindow.statusBar") as? UIView
//               statusBar?.backgroundColor = UIColor.white
//        }
            
         
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
                   self.setnavigationWhite_tintGray()
                        }
//      if #available(iOS 13.0, *) {
//                                                             let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
//                                                             if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
//                                                             statusBar.backgroundColor = UIColor.white
//                                                             }
//
//               } else {
//                     let statusBar = UIApplication.shared.value(forKeyPath:
//                  "statusBarWindow.statusBar") as? UIView
//                      statusBar?.backgroundColor = UIColor.white
//               }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        NotificationCenter.default.addObserver(self, selector: #selector(ArticleDetailsPagerController.UpdateNavigation(notification:)), name: Notification.Name("UpdateNavigation"), object: nil)

        for  article  in articles {
            let articleViewController = storyboard?.instantiateViewController(withIdentifier: "ArticleController" ) as! ArticleController
            articleViewController.article = article
            articleViewControllers.append(articleViewController)
        }
        
        
        self.dataSource = self
        //self.delegate = self
        
        setupNavigationBar()
        
    }
    
    var shareButton:UIBarButtonItem?
    var SavedNewsBar :UIBarButtonItem!
    var SavedNews :UIButton!
    
   
    @objc func  UpdateNavigation  (notification: NSNotification){
       if let searchtext = notification.userInfo?["ID"] as? String {
       
        let  menuButton = UIBarButtonItem(image:
                                    #imageLiteral(resourceName: "menuIcon")
                                    , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
                         let shareImage =  UIImage(named: "uploading-file")
                         shareButton =  UIBarButtonItem(image:shareImage
                             , landscapeImagePhone: nil, style: .done, target: self, action: #selector(share))
                 
                                    SavedNews = UIButton(type: .custom)
                                    SavedNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
                                  
                                        if (self.objectExist(id: searchtext ))
                                        {
                                            SavedNews.setImage(#imageLiteral(resourceName: "SavedPost"), for: .normal)
                                            SavedNews.addTarget(self, action: #selector(unsavePost), for: UIControlEvents.touchUpInside)

                                        }
                                        else {
                                            
                                            
                                            SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                                            SavedNews.addTarget(self, action: #selector(savePost), for: UIControlEvents.touchUpInside)

                                    }
                                    
                                   
        
                                    SavedNews.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                    SavedNewsBar = UIBarButtonItem(customView: SavedNews)
                                    
                                    
                                    let currWidth = SavedNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
                                    currWidth?.isActive = true
                                    let currHeight = SavedNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
                                    currHeight?.isActive = true
                                    
                                    let currWidthshare = shareButton!.customView?.widthAnchor.constraint(equalToConstant: 25)
                                            currWidthshare?.isActive = true
                                    let currHeightshare = shareButton!.customView?.heightAnchor.constraint(equalToConstant: 25)
                                            currHeightshare?.isActive = true
                                    
                                    
                                    self.navigationItem.rightBarButtonItems = [ menuButton, shareButton! ,SavedNewsBar]
                        let yourBackImage = UIImage(named: "Back")
                        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
                        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        }
        
    }
    
    func setupNavigationBar(){
        if #available(iOS 13.0, *) {
        self.setnavigationWhite_tintGray()
             }
        let  menuButton = UIBarButtonItem(image:
                             #imageLiteral(resourceName: "menuIcon")
                             , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
                  let shareImage =  UIImage(named: "uploading-file")
                  shareButton =  UIBarButtonItem(image:shareImage
                      , landscapeImagePhone: nil, style: .done, target: self, action: #selector(share))
          
                             SavedNews = UIButton(type: .custom)
                             SavedNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
                             if let ID = articles[currentIndex!].id {
                                 if (self.objectExist(id: ID ))
                                 {
                                     SavedNews.setImage(#imageLiteral(resourceName: "SavedPost"), for: .normal)
                                    SavedNews.addTarget(self, action: #selector(unsavePost), for: UIControlEvents.touchUpInside)

                                 }
                                 else {
                                     
                                     
                                     SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                                    SavedNews.addTarget(self, action: #selector(savePost), for: UIControlEvents.touchUpInside)

                             }
                             
                             }
                             else {
                                 SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                                SavedNews.addTarget(self, action: #selector(savePost), for: UIControlEvents.touchUpInside)

                                 
                             }
                             SavedNews.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                             SavedNewsBar = UIBarButtonItem(customView: SavedNews)
                             
                             
                             let currWidth = SavedNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
                             currWidth?.isActive = true
                             let currHeight = SavedNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
                             currHeight?.isActive = true
                             
                             let currWidthshare = shareButton!.customView?.widthAnchor.constraint(equalToConstant: 25)
                                     currWidthshare?.isActive = true
                             let currHeightshare = shareButton!.customView?.heightAnchor.constraint(equalToConstant: 25)
                                     currHeightshare?.isActive = true
                             self.navigationItem.rightBarButtonItems = [ menuButton, shareButton! ,SavedNewsBar]
                 let yourBackImage = UIImage(named: "Back")
                 self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
                 self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
    }
    
    @objc func share(){
        let title: String = articles[currentIndex!].title!
        let url: URL! = URL(string: articles[currentIndex!].fullurl!)
        let vc = UIActivityViewController(activityItems: [title, url], applicationActivities: [])
        
        
        let popover = vc.popoverPresentationController
        popover?.sourceView = view
        popover?.barButtonItem = shareButton
        present(vc, animated: true, completion: {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.accentColor], for: .normal)
            
        })
        
    }
    
    func objectExist (id: String) -> Bool {
           
           let realm = try! Realm()
           return realm.object(ofType: SavedArticle.self, forPrimaryKey: id) != nil
       }
       
       @objc func openMenu(){
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            drawer()?.open(to: .left)
        }
        else
        {
            // fa // ar
            drawer()?.open(to: .right)
        }
        
       }
       
       @objc func savePost(){
       if let IDD = (articles[currentIndex!].id!) as String?
        {
        do{
                           let realm = try Realm()
                           
                             try realm.write {

                               let SavedArt = SavedArticle(Art: articles[currentIndex!])
                               SavedArt?.SavedArticel = articles[currentIndex!]
                               SavedArt?.id = IDD
                               print("///////////")
                               print(SavedArt)
                                realm.add(SavedArt!, update: true)
                                let SelectDataDict:[String: String] = ["ID": IDD]
                                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)

                                      
                             }
        }
                             catch let error as NSError {
                               print(error)
                             }
        
        }
           
           
       }
        @objc func unsavePost(){
            if let IDD = (articles[currentIndex!].id!) as String?
                   {
                   do{
                                      let realm = try Realm()
                                      
                                        try realm.write {

                                          let SavedArt = SavedArticle(Art: articles[currentIndex!])
                                          SavedArt?.SavedArticel = articles[currentIndex!]
                                          SavedArt?.id = IDD
                                          print("///////////")
                                          print(SavedArt)
                                              realm.delete(realm.objects(SavedArticle.self).filter("id=%@",IDD))
                                              let SelectDataDict:[String: String] = ["ID": IDD]
                                              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)

                                                 
                                        }
                   }
                                        catch let error as NSError {
                                          print(error)
                                        }
                   
                   }
              
              
          }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        return articleViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return Page.at(index: selectedPageIndex)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return articleViewControllers.count
    }
    
    
    
}
