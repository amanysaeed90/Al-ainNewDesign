import Foundation
import UIKit
import FontAwesome_swift
import Pageboy
import UIView_Shake
import FittedSheets
import RealmSwift
import Realm
import SideMenu
import DrawerMenu
import Localize_Swift
import Tabman

class RootViewController: TabmanViewController  {
    var taxonomiesResponseRealm : Results<TaxonomyResponse>!
    @IBOutlet weak var tabmanView: UIView!
    var taxonomiesResponseToken: NotificationToken?
    var taxonomiesResponse:TaxonomyResponse!
    var homeTaxonomies:[Taxonomy]!
    static var  shared:RootViewController?
    static var displayArticleWithId:String = ""
    
    
    var viewControllers = [UIViewController]()

    
    
    //var hidingNavBarManager: HidingNavigationBarManager?
    //var hidingNavBarManagernews: HidingNavigationBarManager?
    // var hidingNavBarManagertrend: HidingNavigationBarManager?
    
    
    
    override func viewDidLoad() {
        
        
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabmanView.layer.shadowColor = UIColor.black.cgColor
        tabmanView.layer.shadowOpacity = 0.3
        tabmanView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)

        tabmanView.layer.shadowOffset = CGSize.zero
        tabmanView.layer.shadowRadius = 3
        
       // automaticallyAdjustsScrollViewInsets = false
        RootViewController.shared = self
        setupTopBarColors()
    
        super.viewDidLoad()
        self.dataSource = self
                // Create bar
        let bar = TMBar.ButtonBar()
       
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
    
        bar.indicator.overscrollBehavior = .bounce
        bar.layout.interButtonSpacing = 0
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right:0.0)
        bar.layout.alignment = .centerDistributed
        bar.buttons.customize{(button) in
            button.selectedTintColor = #colorLiteral(red: 0.3293722868, green: 0.329434514, blue: 0.3293683529, alpha: 1)
            button.tintColor = #colorLiteral(red: 0.4744554758, green: 0.4745410681, blue: 0.4744500518, alpha: 1)
            button.font =  Fonts.getFont(fontSize: 17)
        }
        addBar(bar, dataSource: self, at: .custom(view: self.tabmanView, layout: nil))
      //  ShadowView.dropShadow(scale: true, color: #colorLiteral(red: 0.03137254902, green: 0.4, blue: 0.3294117647, alpha: 1))
       
        
        if RootViewController.displayArticleWithId != "" {
            AppUtils.launchSingleArticleView(articleId: RootViewController.displayArticleWithId, controller: self)
            RootViewController.displayArticleWithId = ""
        }
        
       // getTaxonmies()
        let image = UIImage(named: "FrenchLogo")
        if #available(iOS 13.0, *) {
           // navBarAppearance.backgroundImage = image
            navBarAppearance.backgroundImageContentMode = .scaleAspectFill
            
        } else {
            // Fallback on earlier versions
        }
      
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        drawer()?.panGestureType = .none
        // hidingNavBarManager?.viewWillDisappear(animated)
        // hidingNavBarManagernews?.viewWillDisappear(animated)
        //hidingNavBarManagertrend?.viewWillDisappear(animated)
    }
    @objc func leftOpen(){
     
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
   
    
  
    private func setupSideMenu() {
        // Define the menus
        
        SideMenuManager.default.menuRightNavigationController = storyboard?.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: view)
    }
    
    func setupTopBarColors(){
     
       // ShadowView.dropShadow(scale: true, color: #colorLiteral(red: 0.03137254902, green: 0.4, blue: 0.3294117647, alpha: 1))
       
        
       /* self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            // indicator
            appearance.indicator.bounces = false
            appearance.indicator.compresses = false
            appearance.indicator.isProgressive = false
            appearance.indicator.useRoundedCorners = true
            appearance.indicator.lineWeight = .thick
            appearance.indicator.color = #colorLiteral(red: 0.6470588235, green: 0.137254902, blue: 0.2235294118, alpha: 1)
            
            // state
            appearance.state.selectedColor = #colorLiteral(red: 0.6470588235, green: 0.137254902, blue: 0.2235294118, alpha: 1)
            //r  appearance.state.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
            // text
            appearance.text.font = Fonts.getFontSelected(fontSize: 16)
            // layout
            appearance.layout.height = .auto//.explicit(value: 36)
            appearance.layout.interItemSpacing = 0.0
            appearance.layout.edgeInset = 0.0
            appearance.layout.itemVerticalPadding = 0.0
            appearance.layout.itemDistribution = .leftAligned
            appearance.layout.extendBackgroundEdgeInsets = true
            // style
            appearance.style.background = .solid(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) //.blur(style: .extraLight).solid(color: Colors.primaryColor)
            appearance.style.bottomSeparatorColor = .clear
            
            // interaction
            appearance.interaction.isScrollEnabled = true
            
            //appearance.layout.itemDistribution = TabmanBar.Appearance.Layout.ItemDistribution.leftAligned
            appearance.layout.minimumItemWidth = (UIScreen.main.bounds.width / 3.3)
            // appearance.layout.interItemSpacing = 5.0
            //  appearance.layout.edgeInset = 0.0
            //             self.view.layer.shadowColor = UIColor.gray.cgColor
            //             self.view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            //             self.view.layer.shadowRadius = 1.5
            //             self.view.layer.shadowOpacity = 0.3
            //             self.view.layer.masksToBounds = false
            //
        })*/
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //drawer()?.panGestureType = .pan
        
//        if let counter = UserDefaults.standard.integer(forKey: "badgeCounter"){
//            badgeCounter = counter
//        }else{
//            badgeCounter = 0
//        }
        super.viewWillAppear(animated)
        // hidingNavBarManager?.viewWillAppear(animated)
        // hidingNavBarManagernews?.viewWillAppear(animated)
        // hidingNavBarManagertrend?.viewWillAppear(animated)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // hidingNavBarManager?.viewDidLayoutSubviews()
        // hidingNavBarManagertrend?.viewDidLayoutSubviews()
        // hidingNavBarManagernews?.viewDidLayoutSubviews()
        
    }
    
    
    // MARK: UITableViewDelegate
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        // hidingNavBarManager?.shouldScrollToTop()
        //  hidingNavBarManagernews?.shouldScrollToTop()
        // hidingNavBarManagertrend?.shouldScrollToTop()
        
        return true
    }
    
    var editMyNews:UIBarButtonItem?
    var menuButton:UIBarButtonItem?
    
    var notificationButton:UIBarButtonItem?
    let notificationView = SSBadgeButton()
    
    
    func setupNavigationBar(){
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //navigationController?.navigationBar.barStyle = .black
        //  self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let newFont = UIFont(name: "DroidArabicKufi", size: 13)!
        let color = #colorLiteral(red: 0.2823529412, green: 0.462745098, blue: 0.4549019608, alpha: 1)
        
        //   UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), NSAttributedStringKey.font: newFont], for: .normal)
        
        menuButton = UIBarButtonItem(image:
                                        #imageLiteral(resourceName: "menuIcon")
                                     , landscapeImagePhone: nil, style: .done, target: self, action: #selector(leftOpen))
        
        
        editMyNews = UIBarButtonItem(image:
                                        UIImage.fontAwesomeIcon(name: .pencil, textColor: UIColor.darkGray, size: CGSize(width: 25, height: 25))
                                     , landscapeImagePhone: nil, style: .done, target: self, action: #selector(editMyNewsTax))
        
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search") , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openSearch))
        
        
        
       /* if let counter = UserDefaults.standard.integer(forKey: "badgeCounter"){
            badgeCounter = counter
            if badgeCounter > 0 {
                notificationView.badge = "\(badgeCounter)"
                notificationView.setImage(#imageLiteral(resourceName: "notificationOn"), for: .normal)
                
            }
            else {
                notificationView.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
                
                notificationView.badgeLabel.isHidden = true
            }
        }*/
      //  NotificationCenter.default.addObserver(self, selector: #selector(self.updateBadge), name: BadgeCounterNotificationName, object: nil)
        
        notificationView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationView.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        notificationView.addTarget(self, action: #selector(openNotification), for: .allEvents)
        
        
        self.navigationItem.rightBarButtonItems = [menuButton!]
        notificationButton = UIBarButtonItem(customView: notificationView)
        self.navigationItem.leftBarButtonItems = [searchButton,notificationButton] as? [UIBarButtonItem]
        
        
        notificationButton?.customView!.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        notificationButtonAnimation()
        
        //        let attributes = [
        //            NSAttributedStringKey.foregroundColor: UIColor.white
        //            , NSFontAttributeName: UIFont(name: "DroidArabicKufi", size: 16)!
        //        ]
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray
            , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
        ] as [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        //  self.title = "العين الاخبارية"
        
        
    }
    //  deinit {
    //     NotificationCenter.default.removeObserver(self)
    // }
   /* @objc func updateBadge (){
        if let counter = UserDefaults.standard.integer(forKey: "badgeCounter"){
            print(counter)
            badgeCounter = counter + 1
            print(badgeCounter)
            
            UserDefaults.standard.set(badgeCounter, forKey: "badgeCounter")
            if (badgeCounter == 0)
            {
                notificationView.badgeLabel.isHidden = true
            }else{
                notificationView.badge =  "\(badgeCounter)"
            }
            UIApplication.shared.applicationIconBadgeNumber = badgeCounter
        }
        
        else {
            
            notificationView.badgeLabel.isHidden = true
        }
    }*/
    func notificationButtonAnimation(){
        
        self.notificationButton?.customView!.shake(10,
                                                   withDelta: 8.0,
                                                   speed: 0.3,
                                                   shakeDirection: ShakeDirection.rotation
        )
        
    }
    
    @objc func openSearch(_ sender: AnyObject) {
        let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController")
        navigationController?.pushViewController(searchViewController!, animated: true)
    }
    
    @objc func openMenu(_ sender: AnyObject) {
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        //menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController . taxonmies = taxonomiesResponse
        // menuViewController.modalTransitionStyle = .crossDissolve
        // present(menuViewController, animated: true, completion: nil)
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        
        let menu = UISideMenuNavigationController(rootViewController: menuViewController)
        //       menu.taxonmies = taxonomiesResponse
        
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    
    @objc func openNotification(_ sender: AnyObject) {
        
        
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationListViewController
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.modalTransitionStyle = .crossDissolve
        notificationView.badgeLabel.isHidden = true
        
        let sheetController = SheetViewController(controller: menuViewController)
        sheetController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        present(sheetController, animated: true, completion: nil)
    }
    
    @objc func editMyNewsTax(_ sender: AnyObject){
        
        let myNewsEditViewController = storyboard?.instantiateViewController(withIdentifier: "MyNewsEditViewController") as! MyNewsEditViewController
        navigationController?.pushViewController(myNewsEditViewController, animated: true)
        
        
    }
    
//    override func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
//
////        if index == 0  && MyTaxonomy.myTaxonomies.count > 0 {
////            self.navigationItem.rightBarButtonItems? =  [menuButton! , editMyNews!]
////        }else if  self.navigationItem.rightBarButtonItems?.count == 2 {
////            self.navigationItem.rightBarButtonItems? =  [menuButton!]
////        }
//
//    }
}

extension RootViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
