//
//  HomePageViewController
//  Al-Ain
//
//  Created by imac on 8/30/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import RealmSwift

class HomePageViewController: UIViewController {
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NetEror: WarningView!

    var HomeResponseRealm : Results<HomeResponse>! //[NotificationItems]()
    var HomeResponseToken: NotificationToken?
    
    var currentPage = 0
    let featuredCellIdentifier = "FeaturedPostCell"
    let PagerCellIdentifier = "PagerCell"

    let cellTypeIDs = [
        Article.NEWS_ARTICLE_TYPE: "NormalPostCell",
        Article.VIDEO_ARTICLE_TYPE: "NormalPostCell",
        Article.OPINION_ARTICLE_TYPE: "OpenionPostCell",
        Article.BANNER_ARTICLE_TYPE: "BannerPostCell"
    ]
    
    let featuredInHome = 0
    let videosInHome = 0
    var latestInHome = 3
    let featuredInSetion = 2
    var numberOfTableViewSections = 0
    
    
    var homeResponse:HomeResponse!
        override var preferredStatusBarStyle: UIStatusBarStyle {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                // Fallback on earlier versions
                return .default
            }
        }
    @objc func retryGetData (){
                 self.showSpinnerClear(onView: self.view)
                 self.loadHome()
                   
               }
    
    func registercell(){
           
           tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
           tableView.register(UINib(nibName: "OpenionPostCell", bundle: nil), forCellReuseIdentifier: "OpenionPostCell")
        tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: "VideoPostCell")

       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIFont.familyNames.forEach({ familyName in
       let fontNames = UIFont.fontNames(forFamilyName: familyName)
       print(familyName, fontNames)
               })
        
      /*  if (UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus || UIDevice.current.screenType == .iPhones_X_XS_11Pro ){
            self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6)

             
         }
         else if (UIDevice.current.screenType == .iPhone_XSMax_11ProMax || UIDevice.current.screenType == .iPhones_6_6s_7_8)
         {
             
            self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

             
             
         }
         else if ( UIDevice.current.screenType == .iPhone_XR_11 )
         {
            self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

            self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6)
            
             
         }
         else
         {
            self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

         }
        */
        
        self.registercell()
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        NetEror.tryagainbtn.addTarget(self, action: #selector(retryGetData), for: .touchUpInside)
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.showSpinner(onView:self.view)

//        self.automaticallyAdjustsScrollViewInsets =  false
//
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            // Fallback on earlier versions
//        }

//        if #available(iOS 13.0, *) {
//                  let app = UIApplication.shared
//                  let statusBarHeight: CGFloat = app.statusBarFrame.size.height
//
//                  let statusbarView = UIView()
//                  statusbarView.backgroundColor = UIColor.white
//                  view.addSubview(statusbarView)
//
//                  statusbarView.translatesAutoresizingMaskIntoConstraints = false
//                  statusbarView.heightAnchor
//                    .constraint(equalToConstant: statusBarHeight).isActive = true
//                  statusbarView.widthAnchor
//                    .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
//                  statusbarView.topAnchor
//                    .constraint(equalTo: view.topAnchor).isActive = true
//                  statusbarView.centerXAnchor
//                    .constraint(equalTo: view.centerXAnchor).isActive = true
//
//               } else {
//                     let statusBar = UIApplication.shared.value(forKeyPath:
//                  "statusBarWindow.statusBar") as? UIView
//                      statusBar?.backgroundColor = UIColor.white
//               }
        if #available(iOS 13.0, *) {
                     
                       }
        
        tableView.estimatedRowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.addPullToRefresh()
        tableView.register(UINib(nibName: "HomeSectionsTitle", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "headerTitleCell")
        loadHome();
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          DispatchQueue.main.async {
                         UIView.performWithoutAnimation {
                             let index = self.tableView.indexPathForSelectedRow
                             if (index != nil){
                                
                                 self.tableView.reloadRows(at: [index!], with: UITableViewRowAnimation.automatic)
                             
                             }
                         }
                     }

    
     }
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { // Change `2.0` to the desired number of seconds.
//                           self.tableView.reloadData()
//                           }
//    }
   
    
    
}


