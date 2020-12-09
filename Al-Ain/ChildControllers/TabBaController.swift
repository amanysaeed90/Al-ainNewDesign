//
//  TabBaController.swift
//  Al-Ain
//
//  Created by amany elhadary on 9/5/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import FittedSheets
import UIView_Shake
import Localize_Swift
@available(iOS 13.0, *)
let navBarAppearance = UINavigationBarAppearance()
var titleFromMenu = ""

class TabBaController: UITabBarController {
    var editMyNews:UIBarButtonItem?
    var menuButton:UIBarButtonItem?
    var Logo:UIBarButtonItem?
    var notificationButton:UIBarButtonItem?
    let notificationView = SSBadgeButton()
    static var  Shared:TabBaController?
    
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
 
    func setupNavigationBar(){
      navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       
        
        let newFont = UIFont(name: "DroidArabicKufi", size: 13)!
        let color = #colorLiteral(red: 0.2823529412, green: 0.462745098, blue: 0.4549019608, alpha: 1)
        
        menuButton = UIBarButtonItem(image:
            #imageLiteral(resourceName: "menuIcon")
            , landscapeImagePhone: nil, style: .done, target: self, action: #selector(leftOpen))
        
        let currWidth = menuButton!.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        
        let currHeight = menuButton!.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search") , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openSearch))
        
        let currWidthsearch = searchButton.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidthsearch?.isActive = true
        
        let currHeightsearch = searchButton.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeightsearch?.isActive = true
        
        //              let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search") , landscapeImagePhone: nil, style: .done, target: self, action: #selector(openSearch))
        
        
        
        
        
      /*
        if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
            badgeCounter = counter
            if badgeCounter > 0 {
                notificationView.badge = "\(badgeCounter)"
                notificationView.setImage(#imageLiteral(resourceName: "notificationOn"), for: .normal)
                
            }
            else {
                notificationView.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
                
                notificationView.badgeLabel.isHidden = true
            }
        }
        */
       // NotificationCenter.default.addObserver(self, selector: #selector(self.updateBadge), name: BadgeCounterNotificationName, object: nil)
        notificationView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationView.badgeEdgeInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 15)
        notificationView.addTarget(self, action: #selector(openNotification), for: .allEvents)
        
        self.navigationItem.rightBarButtonItems = [menuButton!]
        notificationButton = UIBarButtonItem(customView: notificationView)
        self.navigationItem.leftBarButtonItems = [searchButton,notificationButton] as? [UIBarButtonItem]
        notificationButton?.customView!.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        let currWidthnotification = notificationButton!.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidthnotification?.isActive = true
        let currHeightnotification = notificationButton!.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeightnotification?.isActive = true
        notificationButtonAnimation()
     
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray
            , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
            ] as [NSAttributedStringKey : Any]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
       
        
       
  
    }
    @objc func openSearch(_ sender: AnyObject) {
        let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController")
        navigationController?.pushViewController(searchViewController!, animated: true)
    }
    @objc func openNotification(_ sender: AnyObject) {
        
        
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationListViewController
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.modalTransitionStyle = .crossDissolve
        notificationView.badgeLabel.isHidden = true
        notificationView.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
        
        let sheetController = SheetViewController(controller: menuViewController)
        sheetController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        present(sheetController, animated: true, completion: nil)
    }
   /* @objc func updateBadge (){
        if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
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
    
    open var animatedItems: [RAMAnimatedTabBarItem] {
        return tabBar.items as? [RAMAnimatedTabBarItem] ?? []
    }
    override func viewDidAppear(_ animated: Bool) {
        let image = UIImage(named: "1-small")

//        if #available(iOS 13.0, *) {
//         //   navBarAppearance.backgroundImage = image
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 13.0, *) {
//            navBarAppearance.backgroundImageContentMode = .scaleAspectFill
//        } else {
//            // Fallback on earlier versions
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        //imageView.backgroundColor = #colorLiteral(red: 0.2781523466, green: 0.5716015697, blue: 0.5635563731, alpha: 1)
           imageView.contentMode = .scaleAspectFill
           let image = UIImage(named: "FrenchLogo")
           imageView.image = image
        
          navigationItem.titleView = imageView
        
        
       
        
        
        //        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarManager") as? UIView
        //        statusBar?.backgroundColor = UIColor.white
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        //        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        TabBaController.Shared = self
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedStringKey.font:UIFont(name: "DroidArabicKufi-Bold", size: 9)]
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 15) as Any], for: .normal)
        //  UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 21) as Any], for: .selected)
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.darkGray]
        let attributess = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray
            , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
            ] as [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.titleTextAttributes = attributess
        // self.title = "العين الاخبارية"
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.selectedIndex = 4
        //initializeContainers()
        //  self.setSelectIndex(from:0, to: 4)
        self.setupNavigationBar()
        for item in self.tabBar.items! as [UITabBarItem] {
            item.SetImageInsets()
            item.setTitlePositionAdjustment()
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Fonts.getFontSelected(fontSize: 13)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: Fonts.getFontSelected(fontSize: 13)], for: .selected)
        print(Localize.currentLanguage())
        
        self.tabBar.items![4].title = "Home".localized()
        self.tabBar.items![3].title = "Sections".localized()
        self.tabBar.items![2].title = "ViewTabBar".localized()
        self.tabBar.items![1].title = "OpinionTabBar".localized()
        self.tabBar.items![0].title = "MyNewsTabBar".localized()



    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.title == "فكر ورأي" || item.title == "الاقسام" ){
            navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
            navigationController?.navigationBar.layer.shadowOpacity = 1
            navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
            navigationController?.navigationBar.layer.shadowRadius = 2
            navigationController?.navigationBar.layer.masksToBounds = false
            
        }
        else
        {
            navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            navigationController?.navigationBar.layer.shadowOpacity = 0
            navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
            navigationController?.navigationBar.layer.shadowRadius = 0
            navigationController?.navigationBar.layer.masksToBounds = false
            
        }
//        if (item.title == "الرئيسية"){
//            self.navigationController?.navigationBar.topItem?.title = "العين الإخبارية"}
//        else
//        {
//            self.navigationController?.navigationBar.topItem?.title = item.title}
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        
        
        //self.navigationController?.navigationBar.topItem?.title = "العين الإخبارية"
        guard let items = tabBar.items else { return }
        
        
        
        if (titleFromMenu == "فكر ورأي" ){
            navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
            navigationController?.navigationBar.layer.shadowOpacity = 1
            navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
            navigationController?.navigationBar.layer.shadowRadius = 2
            navigationController?.navigationBar.layer.masksToBounds = false
        }
        else
        {
            navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            navigationController?.navigationBar.layer.shadowOpacity = 0
            navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
            navigationController?.navigationBar.layer.shadowRadius = 0
            navigationController?.navigationBar.layer.masksToBounds = false
            
        }
        
        
        //        UITabBar.appearance().barTintColor = UIColor.blue
        self.tabBar.isTranslucent = false
        //self.tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.tabBar.layer.shadowRadius = 4
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
        if #available(iOS 13.0, *) {
            
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
            } else {
                // User Interface is Light
                //                        let appearance = tabBar.standardAppearance
                //                        appearance.shadowImage = nil
                //                        appearance.shadowColor = nil
                //                        tabBar.standardAppearance = appearance;
            }
            
            
        } else {
            // Fallback on earlier versions
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
   
     
        
        
        tabBar.tintColor = #colorLiteral(red: 0.08724304289, green: 0.08205347508, blue: 0.09085503966, alpha: 1)
        tabBar.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor.white
        if #available(iOS 13.0, *) {
            // This only set top status bar as transparent, not the nav bar.
            navBarAppearance .configureWithTransparentBackground()
            // This set the color for both status bar and nav bar(alpha 1).
            navBarAppearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

           // navBarAppearance.titleTextAttributes = [
               // NSAttributedString.Key.foregroundColor: UIColor.darkGray,
              //  NSAttributedString.Key.font: Fonts.getFontSelected(fontSize: 13)]
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2627197802, green: 0.2627618313, blue: 0.2627065182, alpha: 1)

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            // Nav bar need sets to translucent for both nav bar and status bar to be translucent.
            // // Need to reset nav bar's color to make it clear to display navBarAppearance's color
            navigationController?.navigationBar.backgroundColor = UIColor.white
            navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let image = UIImage(named: "KKlogo") //1-small2
            print(UIDevice.modelName)
            if (UIDevice.modelName == "iPhone 7 Plus" ) {
                let image = UIImage(named: "1-small2")
              //  navBarAppearance.backgroundImage = image

                navBarAppearance.backgroundImageContentMode = .scaleAspectFill

            }
            else {
              //  navBarAppearance.backgroundImage = image
                navBarAppearance.backgroundImageContentMode = .scaleAspectFill

            }
           
            
        }
        //          if #available(iOS 13.0, *) {
        //                                                                 let app = UIApplication.shared
        //                                                                 let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        //
        //                                                                 let statusbarView = UIView()
        //                                                                 statusbarView.backgroundColor = UIColor.white
        //                                                 self.view.addSubview(statusbarView)
        //
        //                                                                 statusbarView.translatesAutoresizingMaskIntoConstraints = false
        //                                                                 statusbarView.heightAnchor
        //                                                                   .constraint(equalToConstant: statusBarHeight).isActive = true
        //                                                                 statusbarView.widthAnchor
        //                                                                     .constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        //                                                                 statusbarView.topAnchor
        //                                                                     .constraint(equalTo: self.view.topAnchor).isActive = true
        //                                                                 statusbarView.centerXAnchor
        //                                                                     .constraint(equalTo: self.view.centerXAnchor).isActive = true
        //
        //                                                              } else {
        //                                                                    let statusBar = UIApplication.shared.value(forKeyPath:
        //                                                                 "statusBarWindow.statusBar") as? UIView
        //                                                                     statusBar?.backgroundColor = UIColor.white
        //                                                              }
        //        navigationController?.navigationBar.backgroundColor = UIColor.white
        //        navigationController?.navigationBar.tintColor = UIColor.darkGray
        //        let attributes = [
        //            NSAttributedStringKey.foregroundColor: UIColor.darkGray
        //            , NSAttributedStringKey.font: UIFont(name: "DroidArabicKufi-Bold", size: 17)!
        //            ] as [NSAttributedStringKey : Any]
        //        self.navigationController?.navigationBar.titleTextAttributes = attributes
        if #available(iOS 13.0, *) {
                        self.setnavigationWhite_tintGray()
                    } else {
                        // Fallback on earlier versions
                    }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
