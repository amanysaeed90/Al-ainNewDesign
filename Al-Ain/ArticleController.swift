//
//  ArticleController.swift
//  Al-Ain
//
//  Created by imac on 8/30/17.
//  Copyright © 2017 egygames. All rights reserved.
//


import Foundation
import UIKit
//import ParallaxHeader
import YouTubePlayer
import WebKit
import Social
import AVKit
import AVFoundation
import RealmSwift
import Localize_Swift
class ArticleController : UIViewController,WKUIDelegate{
    
    
    @IBOutlet weak var closeAudioPlayer: UIButton!
    @IBOutlet weak var audioPlayer: UIView!
    @IBOutlet weak var tableView: ScrollStopTableView!
    @IBOutlet var copyRightFooter: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
   // @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var copyRightLbl: UILabel!
    
    var article :Article!
    var articleId:String? = nil
    var relatedArticles :[Related] = []
    
    var fontSize =  100
    let FONT_SIZE_KEY = "fontsize"
    
    let rowsCellsForSection = ["webViewCell","NormalPostCell","topicCell"]//relatedArticleCell
    let sectionCells = ["titleCell","headerTitleCell","headerTitleCell"]
    var taxonomies:[Taxonomy] = []
    var webViewHeight : CGFloat = 0
    var isDataDisplayed = false
    var firstLoaded = true
    var player:AVPlayer?
  //  var videoEmbeded: WKWebView!
 //   @IBOutlet weak var EmbedeViewContainer: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registercell()
        self.showSpinner(onView: self.view)
        tableView.estimatedRowHeight = 311
        tableView.rowHeight = UITableViewAutomaticDimension
        // videoPlayer.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 35
        tableView.register(UINib(nibName: "ArticleHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "titleCell")
        tableView.register(UINib(nibName: "HomeSectionsTitle", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "headerTitleCell")
        //self.tableView.parallaxHeader.view = self.headerView
        //self.tableView.parallaxHeader.mode = .fill
        //self.tableView.parallaxHeader.minimumHeight = 0
        self.tableView.tableFooterView = copyRightFooter
        photoTitle.text = ""
        copyRightFooter.isHidden = true
        copyRightLbl.text = "\("copyRights".localized()) © \(Date().GetCurrentYear())"
        
        

               
        /*
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 1
        navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        navigationController?.navigationBar.layer.shadowRadius = 2
        navigationController?.navigationBar.layer.masksToBounds = false
        */
        
    }
    func registercell(){
        
        tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
    }
    var imageUrl = "";
    func loadData(){
        if isDataDisplayed || article == nil {
            return
        }
        isDataDisplayed = true
        //        if (article.videoCode == nil ){
        //            videoPlayer.isHidden = true
        //            if let imagefounded = article.mainImg , let imagefoundedthum = article.thumbImg {
        //            imageUrl =  article.mainImg == nil ? imagefoundedthum : imagefounded
        //            }
        //            photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openZoomedImage)))
        //            photo.kf.setImage(with: URL(string:(imageUrl)),options: [.transition(.fade(0.2))])
        //            photoTitle.text = article.titleImg
        //            if (article.nodeType == Article.OPINION_ARTICLE_TYPE)
        //            {
        //                photoTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToAutherArticles)))
        //                photoTitle.isUserInteractionEnabled = true
        //            }
        //
        //
        //        }else {
        //            photo.superview?.isHidden = true
        //            videoPlayer.isHidden = false
        //            self.videoPlayer.loadVideoID(self.getVideoId(text:self.article.videoCode!))
        //
        //        }
        // self.tableView.parallaxHeader.height = 50 + (9.0 * self.view.frame.width / 16.0)
        
        
      /*  if (article.videoCode == nil ){
            videoPlayer.isHidden = true
            photo.superview?.isHidden = false
            EmbedeViewContainer.isHidden = true
            if let imagefounded = article.mainImg , let imagefoundedthum = article.thumbImg {
                imageUrl =  article.mainImg == nil ? imagefoundedthum : imagefounded
            }
            photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openZoomedImage)))
            photo.kf.setImage(with: URL(string:(imageUrl)),options: [.transition(.fade(0.2))])
            photoTitle.text = article.titleImg
            if (article.nodeType == Article.OPINION_ARTICLE_TYPE)
            {
                photoTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToAutherArticles)))
                photoTitle.isUserInteractionEnabled = true
            }
            
            
        }else {
            
         
            if((article.videoCode?.contains("youtube")) == true){
                photo.superview?.isHidden = true
                         videoPlayer.isHidden = false
                EmbedeViewContainer.isHidden = true

                self.videoPlayer.loadVideoID(self.getVideoId(text:self.article.videoCode!))
            }else
            {
                photo.superview?.isHidden = true
                    videoPlayer.isHidden = true
                EmbedeViewContainer.isHidden = false
                var html: String = "<html><body>"
                
                
                html.append(article.videoCode ?? "")
                
                
                html.append("</body></html>")
                videoEmbeded.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
                
            }
            
        }*/

        if articleId != nil{
            self.title = article.sectionName
        }
        
        
        
        //AppUtils.showWait(self.view)
        getArticleTaxonomies();
        copyRightFooter.isHidden = false
        
    }
    @objc func goToAutherArticles(_ sender: UIGestureRecognizer)  {
        
        if(article == nil || article.autherID == 0 )
        {   return
        }
        else
        {
            let taxonomy = Taxonomy()
            taxonomy.type = .OPONION
            taxonomy.name = article.autherName
            taxonomy.id = "\(article.autherID)"
            SectionFromMenu = false
            
            AppUtils.launchSectionViewControllerOpenion( taxonomy:taxonomy , controller: RootViewController.shared!  )
        }
        
        
        
        
        
    }
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //          return .lightContent
    //    }
    override func viewWillAppear(_ animated: Bool) {
        
        //
        if #available(iOS 13.0, *) {
            self.setnavigationWhite_tintGray()
            
        }
        //self.navigationController?.navigationBar.topItem?.title = article?.sectionName ?? ""
        self.navigationController?.navigationBar.isTranslucent = false
        
        //        }
        //        else {
        //               UIApplication.shared.statusBarView?.backgroundColor = .white
        //               UIApplication.shared.statusBarStyle = .lightContent
        //        }
        //                  } else {
        //               guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        //            statusBar.backgroundColor = UIColor.white
        // }
        
        
        
        
        self.loadData()
        if(articleId != nil ){
            loadArticleDetails()
        }
        
//       let indexPath = IndexPath(item: 0, section: 0)
//        if let visibleIndexPaths = tableView.indexPathsForVisibleRows?.index(of: indexPath as IndexPath) {
//            self.tableView.reloadRows(at:tableView.indexPathsForVisibleRo, with: .none)
//            if visibleIndexPaths != NSNotFound {
//               // tableView.reloadRows(at: [indexPath], with: .fade)
//            }
//        }
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                let index = self.tableView.indexPathForSelectedRow
                if (index != nil){
                    self.tableView.reloadRows(at: [index!], with: UITableViewRowAnimation.automatic)
                }
//        self.tableView.reloadSections([1], with: .none)
            }
        }
        if firstLoaded {
            self.tableView.setContentOffset(CGPoint(x:0 , y:0 - self.tableView.contentInset.top), animated:false)
            
        }
        
        setupNavigationBar()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        if #available(iOS 13.0, *) {
                 self.setnavigationWhite_tintGray()
                      }
        
        if firstLoaded {
        self.tableView.setContentOffset(CGPoint(x:0 , y:0 - self.tableView.contentInset.top), animated:true)}
        firstLoaded = false
        
        //             if #available(iOS 13.0, *) {
        //                                                                 let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        //                                                                 if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        //                                                                 statusBar.backgroundColor = UIColor.white
        //                                                                 }
        //
        //                    } else {
        //                 guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        //              statusBar.backgroundColor = UIColor.white
        //                    }
        
        
        
    }
    override func willMove(toParentViewController parent: UIViewController?) {
        print("////////////////////")
        // print(parent)
        //        if (parent != nil){
        //        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        //                                                  statusBar?.backgroundColor = UIColor.clear
        //        self.navigationController?.presentTransparentNavigationBar()
        //        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        //        self.navigationController?.navigationBar.tintColor = UIColor.white
        //        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        //        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //         self.navigationController?.navigationBar.layer.shadowRadius = 0.0
        //       self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
        //       self.navigationController?.navigationBar.layer.masksToBounds = true
        //       let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white
        //                                                                         , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
        //                                                                         ] as [NSAttributedStringKey : Any]
        //       self.navigationController?.navigationBar.titleTextAttributes = attributes
        //        self.navigationController?.navigationBar.topItem?.title = ""
        //         // self.navigationController?.navigationBar.barTintColor = color use in secondVC
        //        }
        //
        //       if #available(iOS 13.0, *) {
        //                                                           let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        //                                                           if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        //                                                           statusBar.backgroundColor = UIColor.white
        //                                                           }
        //
        //              } else {
        //           guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        //        statusBar.backgroundColor = UIColor.white
        //              }
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func delay(completion: @escaping () -> ()) {
        let deadline = DispatchTime.now() + .milliseconds(1000)
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if  isMovingFromParentViewController  && player != nil{
            player?.pause()
        }
        AppUtils.removeWait(self.view)
    }
    
    
    
    var shareButton:UIBarButtonItem?
    var SaveButton:UIBarButtonItem?
    var SavedNews :UIButton!
    func setupNavigationBar(){
        
        if articleId != nil {
            let  menuButton = UIBarButtonItem(image:
                #imageLiteral(resourceName: "menuIcon")
                , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
            let shareImage =  UIImage(named: "uploading-file")
            shareButton =  UIBarButtonItem(image:shareImage
                , landscapeImagePhone: nil, style: .done, target: self, action: #selector(share))
            var SavedNewsBar :UIBarButtonItem!
            SavedNews = UIButton(type: .custom)
            SavedNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
            
            if (self.objectExist(id: articleId! ))
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
            let SelectDataDict:[String: String] = ["ID": articleId!]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
        }
        else  if let ID = article?.id {
            let  menuButton = UIBarButtonItem(image:
                #imageLiteral(resourceName: "menuIcon")
                , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
            let shareImage =  UIImage(named: "uploading-file")
            shareButton =  UIBarButtonItem(image:shareImage
                , landscapeImagePhone: nil, style: .done, target: self, action: #selector(share))
            var SavedNewsBar :UIBarButtonItem!
            SavedNews = UIButton(type: .custom)
            
            SavedNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
            if (self.objectExist(id: ID ))
            {
                SavedNews.setImage(#imageLiteral(resourceName: "SavedPost"), for: .normal)
                SavedNews.addTarget(self, action: #selector(unsavePost), for: UIControlEvents.touchUpInside)
                
                
            }
            else {
                
                
                SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                SavedNews.addTarget(self, action: #selector(savePost), for: UIControlEvents.touchUpInside)
                
                
                
            }
            let SelectDataDict:[String: String] = ["ID": ID]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
            
            
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
        if let IDD: String = article?.id
        {
            do{
                let realm = try Realm()
                
                try realm.write {
                    
                    let SavedArt = SavedArticle(Art: article )
                    SavedArt?.SavedArticel = article
                    SavedArt?.id = IDD
                    print("///////////")
                    print(SavedArt)
                    realm.add(SavedArt!, update: true)
                    let SelectDataDict:[String: String] = ["ID": IDD]
                    SavedNews.setImage(#imageLiteral(resourceName: "SavedPost"), for: .normal)
                                  SavedNews.addTarget(self, action: #selector(unsavePost), for: UIControlEvents.touchUpInside)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
                    
                    
                }
            }
            catch let error as NSError {
                print(error)
            }
            
        }
        else if articleId != nil {
            APIManager.getArticleDetails(id:  articleId!,  suceess: { (article:Article) in
                if article != nil {
                    
                    do{
                        let realm = try Realm()
                        try realm.write {
                            let SavedArt = SavedArticle(Art: article)
                            SavedArt?.SavedArticel = article
                            SavedArt?.id = article.id!
                            print("///////////")
                            print(SavedArt)
                            
                            realm.add(SavedArt!, update: true)
                            let SelectDataDict:[String: String] = ["ID": self.articleId!]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
                            self.SavedNews.setImage(#imageLiteral(resourceName: "SavedPost"), for: .normal)
                            self.SavedNews.addTarget(self, action: #selector(self.unsavePost), for: UIControlEvents.touchUpInside)
                            
                            
                        }
                    }
                    catch let error as NSError {
                        print(error)
                    }
                    
                    
                    
                }else {
                    
                    
                }
            }){ (error:Error?) in
                //                           if self.article == nil{
                //                               self.showErrorView()
                //                           }
            }
            
            
            
        }
        
    }
    @objc func unsavePost(){
        if let IDD: String = article?.id
        {
            do{
                let realm = try Realm()
                
                try realm.write {
                    
                    let SavedArt = SavedArticle(Art: article)
                    SavedArt?.SavedArticel = article
                    SavedArt?.id = IDD
                    print("///////////")
                    print(SavedArt)
                    realm.delete(realm.objects(SavedArticle.self).filter("id=%@",IDD))
                    let SelectDataDict:[String: String] = ["ID": IDD]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
                    SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                    SavedNews.addTarget(self, action: #selector(savePost), for: UIControlEvents.touchUpInside)
                                  
                    
                }
            }
            catch let error as NSError {
                print(error)
            }
            
        }
        else if articleId != nil {
                   APIManager.getArticleDetails(id:  articleId!,  suceess: { (article:Article) in
                       if article != nil {
                           
                           do{
                               let realm = try Realm()
                               try realm.write {
                                   let SavedArt = SavedArticle(Art: article)
                                   SavedArt?.SavedArticel = article
                                   SavedArt?.id = article.id!
                                   print("///////////")
                                   print(SavedArt)
                                   
                                realm.delete(realm.objects(SavedArticle.self).filter("id=%@",self.articleId!))
                                   let SelectDataDict:[String: String] = ["ID": self.articleId!]
                                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNavigation"), object: nil, userInfo: SelectDataDict)
                                self.SavedNews.setImage(#imageLiteral(resourceName: "UnSave_Post_Navigation"), for: .normal)
                                self.SavedNews.addTarget(self, action: #selector(self.savePost), for: UIControlEvents.touchUpInside)
                                                 
                                   
                                   
                               }
                           }
                           catch let error as NSError {
                               print(error)
                           }
                           
                           
                           
                       }else {
                           
                           
                       }
                   }){ (error:Error?) in
                       //                           if self.article == nil{
                       //                               self.showErrorView()
                       //                           }
                   }
                   
                   
                   
               }
        
    }
    
    
    
    @objc func share(){
        let title: String = article.title!
        let url: URL! = URL(string: article.fullurl!)
        let vc = UIActivityViewController(activityItems: [title, url], applicationActivities: [])
        let popover = vc.popoverPresentationController
        popover?.sourceView = view
        popover?.barButtonItem = shareButton
        present(vc, animated: true, completion: {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.accentColor], for: .normal)
        })
        
    }
    
    @objc func openZoomedImage(_ sender:UIGestureRecognizer){
        showZoomableImage(imageUrl)
    }
    
    
}
extension UINavigationController {
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
}
