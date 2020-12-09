//
//  NotificationViewController.swift
//  Al-Ain
//
//  Created by Alex on 7/3/18.
//  Copyright © 2018 egygames. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import FontAwesome_swift
import SDWebImage
import RealmSwift
import Alamofire
import ObjectMapper



class NotificationListViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var NetEror: WarningView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var notificationItems : [NotificationItem]? //Results<NotificationItems>! //[NotificationItems]()
    var notificationToken: NotificationToken?
    
    fileprivate func clearNotificationCache() {
        if let clearCacheValue = UserDefaults.standard.object(forKey: "isClearCache") as? String{
            print(clearCacheValue)
            if clearCacheValue == "true"{
                deleteNotifications()
                UserDefaults.standard.set("false", forKey: "isClearCache")
                UserDefaults.standard.synchronize()
            }
        }
    }
    func LoadNotificationData( completion: @escaping (_ sucses: Bool  , _ ListData :[NotificationItem])->()){
        print("home page Requesting ... :" )
        var list:[NotificationItem] = [NotificationItem]()
        Alamofire.request("https://al-ain.net/api/v4/breakingnews/", method: .get , parameters: [:], encoding: URLEncoding.default )
            .responseJSON { response in
                
                
                switch response.result {
                case .success:
                    print("home page Resonse  ... sucsess:" )
                    
                    if let result = response.result.value {
                        print(result)
                        guard let data = result as? NSArray else {
                            completion(true,list)
                            
                            return
                        }
                        
                        for obj in data {
                            guard let homeObj  = Mapper<NotificationItem>().map(JSONObject: obj)
                                else {
                                    completion(false,list)
                                    return
                            }
                            list.append(homeObj)
                        }
                        
                        completion(true , list)
                    }
                case .failure(let error):
                    print("home page error: \(error)")
                    self.NetEror.isHidden = false
                    completion(false,list)
                    
                }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetEror.isHidden = true
        titleLbl.text = "Notifications".localized()
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        let buttonFont = UIFont.fontAwesome(ofSize: 20)
        closeBtn!.titleLabel?.font = buttonFont
        notificationItems = [NotificationItem()]
        // closeBtn!.setTitle(String.fontAwesomeIcon(name: .close), for: .normal)
        
        
        self.LoadNotificationData(completion: {sucsses,notificationList in
            
            self.notificationItems = notificationList
            print(self.notificationItems)
            self.tableView.reloadData()
            
        })
        
        
        //Realm
        //        let realm = RealmService.shared.realm
        //       // notificationItems = realm.objects(NotificationItems.self)
        //        notificationItems = realm.objects(NotificationItems.self).sorted(byKeyPath: "notificationDate", ascending: false)
        //        notificationToken = realm.observe({ (notification, realm) in
        //            self.tableView.reloadData()
        //        })
        //
        clearNotificationCache()
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            //handle error
            print(error ?? "no error detected")
        }
        
        
        UserDefaults.standard.set(-1, forKey: "badgeCounter")
        NotificationCenter.default.post(name: BadgeCounterNotificationName, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.updateBadge), name: BadgeCounterNotificationName, object: nil)
        //        let obj = NotificationItems(body: "aaaaaaaaasdcfgvh dcftvyg aaaaaaaaasdcfgvh dcftvyg aaaaaaaaasdcfgvh dcftvyg aaaaaaaaasdcfgvh dcftvyg aaaaaaaaasdcfgvh dcftvyg ", title: "sxrdctfvgybh fgvhb", article_id: "336071", img: "https://cdn.al-ain.com/images/2017/10/16/53-134645-wwww_159e480051d5ba_350x200.png", ClearCache: false)
        //        RealmService.shared.create(obj)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func deleteNotifications() {
        //        for i in notificationItems{
        //            RealmService.shared.delete(i)
        //        }
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension NotificationListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notificationItems!.count > 51{
            return 50
        }else{
            return notificationItems!.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationItemCell") as? NotificationItemCell
            else { return UITableViewCell()}
        
        let notificationItem = notificationItems![indexPath.row]
        
        cell.configure(with: notificationItem)
        //cell.ArrowImage.image = UIImage.fontAwesomeIcon(name: .angleLeft, textColor: Colors.accentColor,size: CGSize(width: 50, height: 50)) 
        let obj = notificationItems![indexPath.row]
        if let newsID = obj.articleId{
            if let urlnews = obj.details{
                if (obj.details?.fullImage == "") {
                    cell.ArrowImage.isHidden = true
                }
                else
                {
                    cell.ArrowImage.isHidden = false
                }
            }
            else
            {
                
                cell.ArrowImage.isHidden = true
                
                
            }
            
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = notificationItems![indexPath.row]
        if let newsID = obj.articleId{
            if RootViewController.shared == nil {
                if (obj.articleId != 0) {
                    RootViewController.displayArticleWithId = "\(newsID)"
                }
            } else {
                if (obj.articleId != 0 && obj.url != nil && obj.url != "" && obj.details != nil ) {
                    AppUtils.launchSingleArticleView(articleId: "\(newsID)" , controller: RootViewController.shared!)
                    self.dismiss(animated: false, completion: nil)
                }
                
            }
        }
    }
    
}
