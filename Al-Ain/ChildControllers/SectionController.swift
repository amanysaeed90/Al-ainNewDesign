import Foundation
import ESPullToRefresh
import FontAwesome_swift
import UIKit
import RealmSwift
import DrawerMenu
import Windless
import Localize_Swift
class SectionController: UIViewController {
    @IBOutlet weak var NetEror: WarningView!
    var tib:EasyTipView!

    @IBOutlet weak var TopConstratinttabel: NSLayoutConstraint!
    
    var autherCell = false
    @IBOutlet weak var tableView: UITableView!
    let featuredCellIdentifier = "FeaturedPostCell"
    let cellTypeIDs = [
        Article.NEWS_ARTICLE_TYPE: "NormalPostCell",
        Article.VIDEO_ARTICLE_TYPE: "VideoPostCell",
        Article.OPINION_ARTICLE_TYPE: "OpenionPostCell",
        Article.BANNER_ARTICLE_TYPE:  "BannerPostCell"
        
    ]
    var lastContentOffset: CGFloat = 0
    var addToMyNewsBar :UIBarButtonItem!
    var addToMyNews :UIButton!
    open var taxonomy:Taxonomy!
    var articles:[Article] = []
    var currentPage = 0
    var  launchedAsStandAlone = false
    var SectionResponseRealm : Results<Article>! //[NotificationItems]()
    var OpenionArticleID = 0
    
    
    func setTaxonomy( taxonomy:Taxonomy! ){
        self.taxonomy = taxonomy
    }
    
    
    override func viewDidLoad() {
     //   setNeedsScrollViewInsetUpdate()
        //  self.navigationController?.navigationBar.tintColor = UIColor.white
        super.viewDidLoad()
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        NetEror.tryagainbtn.addTarget(self, action: #selector(retryGetData), for: .touchUpInside)
        
        self.showSpinner(onView: self.view)
        
        
        let modelName = UIDevice.modelName
if (modelName == "iPhone 11 Pro Max" || modelName == "iPhone 11"||modelName == "iPhone XR"||modelName == "iPhone 11 Pro"||modelName == "iPhone XR"||modelName == "iPhone XS Max")
        {
            TopConstratinttabel.constant = -95
        }
        else
        {
            TopConstratinttabel.constant = -64
        }
        tableView.dataSource = self
        tableView.delegate = self
        self.registercell()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.windless
        //.apply {
        //$0.beginTime = 1
        //$0.duration = 2
        //$0.animationLayerOpacity = 0.5
        //}
        //            .start()
        //self.loadArticles()
        // setupLoadMore()
        // self.hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: tableView)
        
    }
    @objc func retryGetData (){
        self.loadArticles()        
    }
    
    
    func objectExist (id: String) -> Bool {
        
        let realm = try! Realm()
        return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
    }
    func registercell(){
        
        tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
        tableView.register(UINib(nibName: "OpenionPostCell", bundle: nil), forCellReuseIdentifier: "OpenionPostCell")
        tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: "VideoPostCell")
    }
    func addNavigationButton(){
        
        let menuButton = UIBarButtonItem(image:
            #imageLiteral(resourceName: "menuIcon")
            , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openMenu))
        
        
        do{
            let realm = try Realm()
            try realm.write {
                let tax = MyTaxonomyies(Tax: self.taxonomy)
                tax?.Tax = self.taxonomy
                print("///////////")
                print(tax as Any)
                if (self.objectExist(id: self.taxonomy.id!))
                {
                    let removeFromMyNews = UIButton(type: .custom)
                    removeFromMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
                    removeFromMyNews.setImage(#imageLiteral(resourceName: "stary"), for: .normal)
                    removeFromMyNews.addTarget(self, action: #selector(removeTaxonomeyFromMyNews), for: UIControlEvents.touchUpInside)
                    
                    let removeFromMyNewsBar = UIBarButtonItem(customView: removeFromMyNews)
                    
                    let currWidth = removeFromMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
                    currWidth?.isActive = true
                    let currHeight = removeFromMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
                    currHeight?.isActive = true
                    
                    self.navigationItem.rightBarButtonItems = [ menuButton,removeFromMyNewsBar]                           }
                else {
                    if taxonomy.type == .OPONION{
                        if (OpenionArticleID == 0)
                        {
                            addToMyNews = UIButton(type: .custom)
                            addToMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
                            addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite-White"), for: .normal)
                            addToMyNews.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            addToMyNews.addTarget(self, action: #selector(addTaxonomeyToMyNews), for: UIControlEvents.touchUpInside)
                            addToMyNewsBar = UIBarButtonItem(customView: addToMyNews)
                            
                            
                            let currWidth = addToMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
                            currWidth?.isActive = true
                            let currHeight = addToMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
                            currHeight?.isActive = true
                            self.navigationItem.rightBarButtonItems = [ menuButton,addToMyNewsBar]
                            
                        }
                        else
                        {
                            self.navigationItem.rightBarButtonItems = [ menuButton]
                        }
                        
                    }
                    else
                    {
                        
                        addToMyNews = UIButton(type: .custom)
                        addToMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
                        addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite-White"), for: .normal)
                        addToMyNews.addTarget(self, action: #selector(addTaxonomeyToMyNews), for: UIControlEvents.touchUpInside)
                        addToMyNews.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                        addToMyNewsBar = UIBarButtonItem(customView: addToMyNews)
                        addToMyNewsBar.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                        
                        let currWidth = addToMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
                        currWidth?.isActive = true
                        let currHeight = addToMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
                        currHeight?.isActive = true
                        self.navigationItem.rightBarButtonItems = [ menuButton,addToMyNewsBar]
                    }
                    
                }
            }
        }
        catch let error as NSError {
            print(error)
        }
        
        
        /*  if  MyTaxonomy.isTaxonomyInMyTaxonomies(taxonomy){
         let removeFromMyNews = UIButton(type: .custom)
         removeFromMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
         removeFromMyNews.setImage(#imageLiteral(resourceName: "stary"), for: .normal)
         removeFromMyNews.addTarget(self, action: #selector(removeTaxonomeyFromMyNews), for: UIControlEvents.touchUpInside)
         
         let removeFromMyNewsBar = UIBarButtonItem(customView: removeFromMyNews)
         
         let currWidth = removeFromMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
         currWidth?.isActive = true
         let currHeight = removeFromMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
         currHeight?.isActive = true
         
         self.navigationItem.rightBarButtonItems = [ menuButton,removeFromMyNewsBar]
         } else {
         if taxonomy.type == .OPONION{
         if (OpenionArticleID == 0)
         {
         let addToMyNews = UIButton(type: .custom)
         addToMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
         addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite-White"), for: .normal)
         addToMyNews.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         addToMyNews.addTarget(self, action: #selector(addTaxonomeyToMyNews), for: UIControlEvents.touchUpInside)
         
         let addToMyNewsBar = UIBarButtonItem(customView: addToMyNews)
         
         
         let currWidth = addToMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
         currWidth?.isActive = true
         let currHeight = addToMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
         currHeight?.isActive = true
         
         
         self.navigationItem.rightBarButtonItems = [ menuButton,addToMyNewsBar]
         
         }
         else
         {
         self.navigationItem.rightBarButtonItems = [ menuButton]
         }
         
         }
         else
         {
         
         let addToMyNews = UIButton(type: .custom)
         addToMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
         addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite-White"), for: .normal)
         addToMyNews.addTarget(self, action: #selector(addTaxonomeyToMyNews), for: UIControlEvents.touchUpInside)
         addToMyNews.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         let addToMyNewsBar = UIBarButtonItem(customView: addToMyNews)
         
         let currWidth = addToMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
         currWidth?.isActive = true
         let currHeight = addToMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
         currHeight?.isActive = true
         self.navigationItem.rightBarButtonItems = [ menuButton,addToMyNewsBar]
         }
         
         
         }*/
    }
    @objc func addTaxonomeyToMyNews(){
        
        
        
        MyTaxonomy.add(self.taxonomy)
        self.navigationItem.rightBarButtonItems?.removeLast()
        
        let removeFromMyNews = UIButton(type: .custom)
        removeFromMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
        removeFromMyNews.setImage(#imageLiteral(resourceName: "stary"), for: .normal)
        removeFromMyNews.addTarget(self, action: #selector(removeTaxonomeyFromMyNews), for: UIControlEvents.touchUpInside)
        
        let removeFromMyNewsBar = UIBarButtonItem(customView: removeFromMyNews)
        
        
        let currWidth = removeFromMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = removeFromMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        
        self.navigationItem.rightBarButtonItems?.append(removeFromMyNewsBar)
        
        let banner = Banner(title: "",subtitle:"AddFavoriteSaction".localized(),  backgroundColor: UIColor.black)
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
        //    }
        //        }
        
        
        
        
        
    }
    
    
    
    
    @objc func removeTaxonomeyFromMyNews(){
        //        SweetAlert().showAlert("حذف التصنيف؟", subTitle: "سيتم حذف التصنيف من اختياراتك", style: AlertStyle.warning, buttonTitle:"الغاء", buttonColor:Colors.selectedTabBGColor , otherButtonTitle:  "موافق", otherButtonColor: Colors.primaryColor) { (isOtherButton) -> Void in
        //            if isOtherButton == true {
        //
        //            }
        //            else {
        
        //        for (index , t) in  MyTaxonomy.myTaxonomies.enumerated() {
        //            if t.id == self.taxonomy.id {
        //                MyTaxonomy.myTaxonomies.remove(at: index)
        //                break
        //            }
        //        }
        //  MyTaxonomy.RemoveTaxonomy(self.taxonomy)
        
        MyTaxonomy.save(self.taxonomy)
        self.navigationItem.rightBarButtonItems?.removeLast()
        
        addToMyNews = UIButton(type: .custom)
        addToMyNews.frame = CGRect(x: 0.0, y: 0.0, width: 5, height: 5)
        
        if (self.tableView.contentOffset.y > 160){
            addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite_gray"), for: .normal)
        }
        else 
        {
            addToMyNews.setImage(#imageLiteral(resourceName: "star-shape-favorite-White"), for: .normal)
            
        }
        
        addToMyNews.addTarget(self, action: #selector(addTaxonomeyToMyNews), for: UIControlEvents.touchUpInside)
        let addToMyNewsBar = UIBarButtonItem(customView: addToMyNews)
        let currWidth = addToMyNewsBar.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = addToMyNewsBar.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        
        
        
        self.navigationItem.rightBarButtonItems?.append(addToMyNewsBar)
        
        let banner = Banner(title: "",subtitle:"RemoveFavoriteSection".localized(),  backgroundColor: UIColor.black)
        banner.dismissesOnTap = true
        banner.show(duration: 4.0)
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
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (articles.count == 0){
            setupLoadMore()
        }
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                let index = self.tableView.indexPathForSelectedRow
                if (index != nil){
                    self.tableView.reloadRows(at: [index!], with: UITableViewRowAnimation.automatic)
                }
            }
        }
        self.navigationController?.navigationBar.isTranslucent = true
        
        if launchedAsStandAlone {
            title = taxonomy.name
            let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            addNavigationButton()
            
        }
        //
        //        let attributes = [
        //            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
        //                , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
        //            ] as! [NSAttributedStringKey : Any]
        //        navigationController?.navigationBar.titleTextAttributes = attributes
        //        navigationController?.navigationBar.topItem?.title = taxonomy.name
        //       // navigationController?.presentTransparentNavigationBar()
        //        navigationController?.navigationBar.backgroundColor = UIColor.clear
        //        navigationController?.navigationBar.tintColor = UIColor.white
        checkOffsetToChangeNavColor()
        //        tableView.isSkeletonable = true
        //        view.showAnimatedSkeleton()
        
        //        if #available(iOS 13.0, *) {
        //                             let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        //                                                                                      if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        //                                                                                      statusBar.backgroundColor = UIColor.clear
        //                                                                                      }
        //
        //
        //                         } else {
        //                               let statusBar = UIApplication.shared.value(forKeyPath:
        //                            "statusBarWindow.statusBar") as? UIView
        //                                statusBar?.backgroundColor = UIColor.clear
        //                         }
        
        if #available(iOS 13.0, *) {
            self.setnavigationClear_tintWhite()
//            navBarAppearance.backgroundImage = nil
//            navBarAppearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.0)

        }
        
    }
    override func willMove(toParentViewController parent: UIViewController?) {
        print("////////////////////")
        print(parent)
        if #available(iOS 13.0, *) {
           // self.setnavigationClear_tintWhite()
        } else {
            //                         let statusBar = UIApplication.shared.value(forKeyPath:
            //                      "statusBarWindow.statusBar") as? UIView
            //                          statusBar?.backgroundColor = UIColor.clear
        }
        // self.navigationController?.presentTransparentNavigationBar()
        //            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        //            self.navigationController?.navigationBar.tintColor = UIColor.white
        //
        //           self.navigationController?.navigationBar.layer.masksToBounds = true
        //           let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white
        //                                                                             , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
        //                                                                             ] as [NSAttributedStringKey : Any]
        //           self.navigationController?.navigationBar.titleTextAttributes = attributes
        //            self.navigationController?.navigationBar.topItem?.title = ""
        // self.navigationController?.navigationBar.barTintColor = color use in secondVC
        
        
    }
    
    func checkOffsetToChangeNavColor(){
        print(self.tableView.contentOffset.y)
        if (self.tableView.contentOffset.y > 160)
        {
            
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite_gray"), for: .normal)
                if #available(iOS 13.0, *) {
                    self.setnavigationWhite_tintGray()}
                
            }, completion: {(finished:Bool) in
                //                                                       self.navigationController?.navigationBar.layer.shadowColor = #colorLiteral(red: 0.7150640488, green: 0.7108152509, blue: 0.7183313966, alpha: 1)
                //                                                       self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                //                                                       self.navigationController?.navigationBar.layer.shadowRadius = 3.0
                //                                                       self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
                
            })
            
            
            
        }
        else
        {
            UIView.animate(withDuration: 0.4) {
                
                //                                   if #available(iOS 13.0, *) {
                //                                                                                      let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                //                                                                                                                                                     if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                //                                                                                                                                                     statusBar.backgroundColor = UIColor.clear
                //                                                                                                                                                     }
                //
                //
                //                                                                                        } else {
                //                                                                                              let statusBar = UIApplication.shared.value(forKeyPath:
                //                                                                                           "statusBarWindow.statusBar") as? UIView
                //                                                                                               statusBar?.backgroundColor = UIColor.clear
                //                                                                                        }
                
                
                self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
              //  if #available(iOS 13.0, *) {self.setnavigationClear_tintWhite()}
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if launchedAsStandAlone && !UserDefaults.standard.bool(forKey: "toolTibShown"){
            if (self.OpenionArticleID == 0){
                 tib = EasyTipView(text:  " من هنا يمكنك متابعة التصنيف في اختياراتك")
                
                tib.show(forItem: (self.navigationItem.rightBarButtonItems?[1])!,
                         withinSuperView: self.navigationController?.view
                )
                UserDefaults.standard.set(true ,  forKey: "toolTibShown")
            }
            
        }
        
        self.checkOffsetToChangeNavColor()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        tib?.dismiss()
    }
    
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        hidingNavBarManager?.viewWillDisappear(animated)
    //
    //    }
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        hidingNavBarManager?.viewDidLayoutSubviews()
    //    }
    //    override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    //        hidingNavBarManager?.shouldScrollToTop()
    //        return true
    //    }
    
    
    
}








