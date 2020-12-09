//
//  MenuViewController.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import LUExpandableTableView
import SwiftOverlays
import RealmSwift
import Realm
import Localize_Swift
var SectionFromMenu = false
class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: LUExpandableTableView!
    
    @IBOutlet weak var bgMenuen: UIImageView!
    @IBOutlet weak var bgMenuAr: UIImageView!
    @IBOutlet weak var settingsBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var helpBtn: UIButton!
      @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var instgram: UIButton!
    @IBOutlet weak var googlePlus: UIButton!
    
    let socialLinks = ["https://www.facebook.com/AlAinNews",
                       "https://twitter.com/alain_4u",
                       "https://www.youtube.com/c/AlAinNews/",
                       "https://www.instagram.com/AlAinNews/",
                       "https://plus.google.com/113344465679815713177"]
    
    let socialLinksPersian = ["https://www.facebook.com/AlainPersian/",
                       "https://twitter.com/AlainPersian",
                       "https://bit.ly/AlainPersian",
                       "https://www.instagram.com/ainpersian_/",
                       "https://plus.google.com/113344465679815713177"]
    
    let socialLinksTurkish = ["https://www.facebook.com/alainturkey/",
                       "https://twitter.com/AlainTurk",
                       "https://bit.ly/AlainHaberleri",
                       "https://www.instagram.com/alainturk_/",
                       "https://plus.google.com/113344465679815713177"]
    
    let socialLinksFrench = ["https://www.facebook.com/AlainFrNews/",
                       "https://twitter.com/AlainFrNews",
                       "https://bit.ly/AlainFrNews",
                       "https://www.instagram.com/alainnewsfr/",
                       "https://plus.google.com/113344465679815713177"]
    let socialLinksAmharic = ["https://www.facebook.com/AlAinAmharic/",
                       "https://twitter.com/AlainAmharic",
                       "https://bit.ly/AlAinAmharic",
                       "https://www.instagram.com/alainnewsamharic/",
                       "https://plus.google.com/113344465679815713177"]
    
    
    let cellReuseIdentifier = "MenuItemCell"
    let sectionHeaderReuseIdentifier = "MenuItemHeader"
    
    var taxonmies :TaxonomyResponse!
    static let  taxonmyTitles = [
     
        "Home".localized()
        ,"Opinion".localized()
        ,"Vedio".localized()
        ,"InfoGraph".localized()
        ,"Photos".localized()
        ,"Sections".localized()
        ,"Hashtags".localized()
        ,"Countries".localized()
        ,"Pages".localized()
        ,"About".localized()
        
     
      
    ]
    
    
    
    
//    "عن العين الإخباریة"
//    ,"البلدان"
//    ,"فيديو"
//    ,"انفوجراف"
//    ,"صور"
//    ,"صفحات العين"
//    ,"هاشتاقات"]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = UIColor.white
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            bgMenuAr.isHidden = true
            bgMenuen.transform = CGAffineTransform(scaleX: -1, y: 1)

        }
        else
        {
            // fa // ar
            bgMenuen.isHidden = true
        }
        
        //UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        self.getTaxonmies()
        //view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       // view.insertSubview(blurEffectView, at: 0);
        tableView.register(UINib(nibName: "MenuHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
        //tableView.register(MenuItemCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        //view.isOpaque = false
      // setupButtons()
       //view.tintColor = UIColor.white
        tableView.expandableTableViewDataSource = self
        tableView.expandableTableViewDelegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
      
    }
    
    func setupButtons() {
        
        
        let buttonFont = UIFont.fontAwesome(ofSize: 25)
        
        closeBtn!.titleLabel?.font = buttonFont
       // closeBtn!.setTitle(String.fontAwesomeIcon(name: .close), for: .normal)
        closeBtn!.setImage(#imageLiteral(resourceName: "No"), for: .normal)
       
        settingsBtn!.titleLabel?.font = buttonFont
        //settingsBtn!.setTitle(String.fontAwesomeIcon(name: .cog), for: .normal)
        settingsBtn!.setImage(#imageLiteral(resourceName: "Notofication"), for: .normal)

        helpBtn!.titleLabel?.font = buttonFont
       // helpBtn!.setTitle(String.fontAwesomeIcon(name: .questionCircle), for: .normal)
        helpBtn!.setImage(#imageLiteral(resourceName: "Notofication"), for: .normal)

        settingsBtn.isHidden = true
        var socialimage:[UIImage] = [#imageLiteral(resourceName: "Facebook"),#imageLiteral(resourceName: "Twitter"),#imageLiteral(resourceName: "Youtube"),#imageLiteral(resourceName: "Instagram"),#imageLiteral(resourceName: "Google Plus")]
        
        let socilaIcons:[FontAwesome] = [FontAwesome.facebook , FontAwesome.twitter , FontAwesome.youTube , FontAwesome.instagram , FontAwesome.googlePlus]
        
        let socialButtons = [facebook,twitter,youtube,instgram,googlePlus]
        
        for (index,btn ) in socialButtons.enumerated() {
            btn?.titleLabel?.font = buttonFont
            btn?.setTitle(String.fontAwesomeIcon(name: socilaIcons[index]), for: .normal)
            btn?.setImage(socialimage[index], for: .normal)
        }
    }
    
    @IBAction func close(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
          drawer()?.close(to: .right)
        drawer()?.close(to: .left)

    }
    @IBAction func help(_ sender: Any) {
           drawer()?.close(to: .right)
            drawer()?.close(to: .left)

        //dismiss(animated: true, completion: nil)
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        
        let about = mainView.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        RootViewController.shared?.navigationController?.pushViewController(about, animated: true)
//
    }
    
  
    
    
    @IBAction func openSocial(_ sender: UIButton) {
        let tag = sender.tag
      
        if Localize.currentLanguage() == "tr" {

            UIApplication.shared.open(URL(string:socialLinksTurkish[tag])!, completionHandler: nil)
        }
        else if Localize.currentLanguage() == "am" {

            UIApplication.shared.open(URL(string:socialLinksAmharic[tag])!, completionHandler: nil)
        }
        else if Localize.currentLanguage() == "fr" {

            UIApplication.shared.open(URL(string:socialLinksFrench[tag])!, completionHandler: nil)
        }
        else if Localize.currentLanguage() == "fa" {

            UIApplication.shared.open(URL(string:socialLinksPersian[tag])!, completionHandler: nil)
        }
        else
        {
           
            UIApplication.shared.open(URL(string:socialLinks[tag])!, completionHandler: nil)
        }
        
    }
    
    
    func getTaxonmies(){
        // setSegmentedAsPagger()
        
       // SwiftOverlays.showBlockingWaitOverlayWithText("جار التحميل")
        if Reachability.isConnectedToNetwork() == true {
            
            APIManager.getTaxonimies(suceess: { (response:TaxonomyResponse) in
                self.taxonmies =  response
            }) { (error:Error?) in
            }
        }/*
         else
         {
         
         
         let realm = RealmService.shared.realm
         // notificationItems = realm.objects(NotificationItems.self)
         taxonomiesResponseRealm = realm.objects(TaxonomyResponse.self)//.sorted(byKeyPath: "Date", ascending: false)
         
         self.taxonomiesResponse =  taxonomiesResponseRealm.first
         if (self.taxonomiesResponse != nil){
         
         self.homeTaxonomies = self.addStaticTaxonomies(self.taxonomiesResponse.sections)
         var items:[Item] = []
         if(self.taxonomiesResponse != nil)
         {
         
         for taxonomy in (self.homeTaxonomies)! {
         switch taxonomy.type{
         case .HOME:
         let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
         self.childs.insert(homeView,at:0)
         break
         case .MYNEWS :
         
         let mynewsController = self.storyboard?.instantiateViewController(withIdentifier: "MyNewsViewController") as! MyNewsViewController
         self.childs.insert(mynewsController,at:0)
         break
         
         
         default:
         let sectionController = self.storyboard?.instantiateViewController(withIdentifier: "SectionController") as! SectionController
         sectionController.setTaxonomy( taxonomy: taxonomy )
         self.childs.insert(sectionController,at:0)
         }
         
         
         let item = Item(title: taxonomy.name!)
         items.insert(item,at:0)
         // self.bar.items = items
         }
         
         //self.bar.items = items
         }
         
         SwiftOverlays.removeAllBlockingOverlays()
         self.dataSource = self
         self.reloadPages()
         }
         else
         {
         self.showErrorView()
         
         }
         }
         */
        
    }
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
    
    
}












