//
//  SavedVC.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/8/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift

final class SavedVC: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    @IBOutlet weak var tableView: ScrollStopTableView!
    
    @IBOutlet weak var emptySavedNews: WarningView!
    var articles:[SavedArticle] = []
    var SectionResponseRealm : Results<SavedArticle>! //[NotificationItems]()
    let cellTypeIDs = [
        Article.NEWS_ARTICLE_TYPE: "NormalPostCell",
        Article.VIDEO_ARTICLE_TYPE: "VideoPostCell",
        Article.OPINION_ARTICLE_TYPE: "OpenionPostCell",
        Article.BANNER_ARTICLE_TYPE: "BannerPostCell"
        
    ]
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("SavedVC View Controller Will Disappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.registercell()
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SavedVC.SelectDataToDeletSavePost(notification:)), name: Notification.Name("SelectDataToDeletSavePost"), object: nil)
    }
   

    override func viewWillAppear(_ animated: Bool) {
        print("SavedVC View Controller Will Appear")

        self.showSpinner(onView: self.view)
        self.emptySavedNews.isHidden = true
        emptySavedNews.HeaderText = "NoSavedNews".localized()
        emptySavedNews.DescriptionText = "AllNewsAppearHere".localized()
        emptySavedNews.ImgName = "noSaved"
        self.LoadData()
    }
    @objc func SelectDataToDeletSavePost(notification: NSNotification){
        if let selectedPath = notification.userInfo?["IndethOfDeleted"] as? IndexPath {
            let realm = RealmService.shared.realm
            SectionResponseRealm = realm.objects(SavedArticle.self)
            let articles = SectionResponseRealm.toArray(ofType: SavedArticle.self)
            self.articles = articles
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [selectedPath], with: .none)
            self.tableView.endUpdates()
              self.LoadData()
            if ( articles.count == 0)
            {
                self.emptySavedNews.isHidden = false
            }
            else
            {
                self.emptySavedNews.isHidden = true
                
            }
            
        }
        
        
    }
    func registercell(){
           
           tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
           tableView.register(UINib(nibName: "OpenionPostCell", bundle: nil), forCellReuseIdentifier: "OpenionPostCell")
           tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: "VideoPostCell")
       }
    func LoadData (){
        
        let realm = RealmService.shared.realm
        // notificationItems = realm.objects(NotificationItems.self)
        SectionResponseRealm = realm.objects(SavedArticle.self)
        let articles = SectionResponseRealm.toArray(ofType: SavedArticle.self)
        self.removeSpinner()
        if articles.count>0{ //pull to refresh
            //self.articles = []
            //self.tableView.reloadData()
            
            
        }
        else
        {
            
            emptySavedNews.HeaderText = "NoSavedNews".localized()
            emptySavedNews.DescriptionText = "AllNewsAppearHere".localized()
            emptySavedNews.ImgName = "noSaved"
            self.emptySavedNews.isHidden = false
            
        }
        
        var newArticles = articles
        //         if(articles.count < APIManager.MAX_COUNT){ // no more data available
        //             self.tableView.es_noticeNoMoreData()
        //         }else{
        //             newArticles.removeLast()
        //         }
        let newArticlesCount = newArticles.count
        let olderCount = self.articles.count
        self.articles = articles.reversed()
        
        var indexPaths = [IndexPath]()
        for i in 0..<newArticlesCount {
            indexPaths.append(IndexPath(row: olderCount + i, section: 0))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        //         self.tableView.beginUpdates()
        //         self.tableView.insertRows(at: indexPaths, with: .none)
        //         self.tableView.endUpdates()
        self.tableView.es_stopPullToRefresh()
        self.tableView.es_stopLoadingMore()
       // self.setNeedsScrollViewInsetUpdate()
        
    }
    
    
    
    
}
extension SavedVC {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return 130
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return UITableViewAutomaticDimension
           
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.removeSpinner()
        var cellId:String = "NormalPostCell"
        let article = self.articles[indexPath.row].SavedArticel!
        cellId = self.cellTypeIDs[article.nodeType!]!
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell", for: indexPath) as? PostCell
        cell?.parentViewController = self
        
        cell?.configureWithData(self.articles[indexPath.row].SavedArticel!)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ArticelsArray = self.articles.map { $0.SavedArticel }
        AppUtils.launchArticlesPagerController(articles: ArticelsArray as! [Article] , index : indexPath.row, controller: self ,title:"اخبار محفوظة")
        
    }
    
    
}
