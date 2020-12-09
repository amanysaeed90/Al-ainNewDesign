//
//  InfoGraphVC.swift
//  Al-Ain
//
//  Created by al-ain nine on 11/6/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift

class InfoGraphVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var articles:[Article] = []
    var currentPage = 0
    var SectionResponseRealm : Results<Article>! //[NotificationItems]()
    @IBOutlet weak var NetEror: WarningView!
    
    let taxonomy = Taxonomy()
    
    @IBOutlet weak var tableView: ScrollStopTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(onView: self.view)
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        NetEror.tryagainbtn.addTarget(self, action: #selector(retryGetData), for: .touchUpInside)

        taxonomy.type = .INFOGRAPH
        tableView.estimatedRowHeight = 311
        tableView.rowHeight = UITableViewAutomaticDimension
        //
        setupLoadMore()
        
        // self.loadArticles()
        // Do any additional setup after loading the view.
    }
    @objc func retryGetData (){
        self.showSpinner(onView: self.view)
        self.loadArticles()
                 
             }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillAppear(_ animated: Bool) {
        
        if (articles.count == 0){
        self.loadArticles()
        }
        else {
            if Reachability.isConnectedToNetwork() == true {
                    self.loadArticles()
            }
        }
        
    }
}
extension InfoGraphVC  {
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 311
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId:String = "VideoPostCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
        cell?.parentViewController = self
        cell?.configureWithData(self.articles[indexPath.row])
        return cell!
        
    }
    
    //     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    //    {
    //
    //
    //
    ////        UIView.animate(withDuration: 0.2, animations: {
    ////         //   cell.contentView.alpha = 1.0
    ////
    ////
    ////        })
    ////
    ////
    //    }
    
    
    
    
}
// MAK: - UITableDelegate
extension InfoGraphVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var  title = ""
        if taxonomy.name != nil {
            title = taxonomy.name!
        }
        
        AppUtils.launchArticlesPagerController(articles: self.articles, index : indexPath.row, controller: self ,title:title)
        
    }
    
}
extension InfoGraphVC {
    
    func loadArticles(){
        //tableView.windless.end()
        self.NetEror.isHidden = true

      //  if Reachability.isConnectedToNetwork() == true {
            
            if(self.currentPage == 0)        {
                //AppUtils.showWait(self.tableView)
            }
            APIManager.getArticles(taxonomy: self.taxonomy, page: self.currentPage, suceess: { (articles:[Article]) in
                self.removeSpinner()
                
                if self.currentPage == 0 &&  self.articles.count>0{ //pull to refresh
                    self.articles = []
                    self.tableView.reloadData()
                }
                
                
                var newArticles = articles
                if(articles.count < APIManager.MAX_COUNT){ // no more data available
                    self.tableView.es_noticeNoMoreData()
                }else{
                    newArticles.removeLast()
                }
                let newArticlesCount = newArticles.count
                
                let olderCount = self.articles.count
                self.articles.append(contentsOf: newArticles)
                
//                do{
//                    let realm = try Realm()
//                    try realm.write {
//                        realm.add(newArticles,update: true)
//                    }
//                }
//                catch let error as NSError {
//                }
                var indexPaths = [IndexPath]()
                for i in 0..<newArticlesCount {
                    indexPaths.append(IndexPath(row: olderCount + i, section: 0))
                }
                
                
                
                if(self.currentPage == 0)        {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else {
                    // self.tableView.deleteRows(at: indexPaths, with: .none)
                    self.tableView.beginUpdates()
                    
                    self.tableView.insertRows(at: indexPaths, with: .none)
                    self.tableView.endUpdates()
                }
                
                self.view.hideSkeleton()
                // self.tableView.windless.end()
                
                
                if(self.currentPage == 0)        {
                    AppUtils.removeWait(self.view)
                }
                
                self.tableView.es_stopPullToRefresh()
                self.tableView.es_stopLoadingMore()
               // self.setNeedsScrollViewInsetUpdate()
                if Reachability.isConnectedToNetwork() == false {
                    self.shownoNetToast()
                }
            }) { (error:Error?) in
                if(self.currentPage == 0)        {
                    //self.showErrorView()
                    self.NetEror.isHidden = false
                    self.removeSpinner()
                    
                }
                else{
                    self.shownoNetToast()
                    self.removeSpinner()
                    
                }
            }
            
       // }
       /* else
        {                self.removeSpinner()
            
            //Realm
            if (articles.count == 0){
            self.NetEror.isHidden = false
            }
            //self.homeResponse = HomeResponseRealm.first
            //print(self.homeResponse)
            /*  if( self.currentPage == 0){
             print()
             let realm = RealmService.shared.realm
             // notificationItems = realm.objects(NotificationItems.self)
             if (self.taxonomy.name != "فيديو"){
             if self.taxonomy.id != nil {
             
             SectionResponseRealm = realm.objects(Article.self).filter("sectionId = %@ AND videoCode == nil", self.taxonomy.id!).sorted(byKeyPath: "updated", ascending: false)
             let articles = SectionResponseRealm.toArray(ofType: Article.self)
             
             if self.currentPage == 0 &&  self.articles.count>0{ //pull to refresh
             self.articles = []
             self.tableView.reloadData()
             }
             
             
             var newArticles = articles
             if(articles.count < APIManager.MAX_COUNT){ // no more data available
             self.tableView.es_noticeNoMoreData()
             }else{
             newArticles.removeLast()
             }
             let newArticlesCount = newArticles.count
             
             let olderCount = self.articles.count
             self.articles.append(contentsOf: newArticles)
             
             
             var indexPaths = [IndexPath]()
             for i in 0..<newArticlesCount {
             indexPaths.append(IndexPath(row: olderCount + i, section: 0))
             }
             
             
             
             self.tableView.beginUpdates()
             self.tableView.insertRows(at: indexPaths, with: .none)
             self.tableView.endUpdates()
             
             
             if(self.currentPage == 0)        {
             AppUtils.removeWait(self.view)
             }
             
             self.tableView.es_stopPullToRefresh()
             self.tableView.es_stopLoadingMore()
             self.setNeedsScrollViewInsetUpdate()
             }
             else
             {
             self.shownoNetToast()
             }
             }
             
             }else{
             
             self.shownoNetToast()
             
             }*/
            self.tableView.es_stopPullToRefresh()
            self.tableView.es_stopLoadingMore()
            
            
            
            
        }*/
        
    }
    
    func setupLoadMore(){
        
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            self?.currentPage = 0
            self?.loadArticles()
        }
        
        self.tableView.es_addInfiniteScrolling {
            [weak self] in
            self?.currentPage += 1
            self?.loadArticles()
        }
    }
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(retry));
    }
    
    
    @objc func retry (_ sender: UIGestureRecognizer){
        
        self.loadArticles()
        
    }
    func shownoNetToast(){
        var point:CGPoint = CGPoint()
        if ( self.currentPage != 0){
            point = CGPoint(x: self.tableView.bounds.size.width / 2.0, y: (self.tableView.contentSize.height - 80))
        }
        else
        {
            point = CGPoint(x: self.tableView.bounds.size.width / 2.0, y: (self.tableView.bounds.size.height - 80))
            
            
        }
        self.tableView.makeToast("NetWorkFailedDescription".localized(), point: point, title: "", image: nil, completion: nil)
    }
    
}

