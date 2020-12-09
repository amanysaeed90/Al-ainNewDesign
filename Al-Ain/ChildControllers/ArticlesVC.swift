//
//  ArticlesVC.swift
//  Al-Ain
//
//  Created by amany elhadary on 7/11/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift

class ArticlesVC: UIViewController {
    @IBOutlet weak var NetEror: WarningView!
    
    @IBOutlet weak var shadowView: RoundedCornerView!
    var articles:[Article] = []
    var currentPage = 0
    var SectionResponseRealm : Results<Article>! //[NotificationItems]()
    
    @IBOutlet weak var tableView: ScrollStopTableView!
    let taxonomy = Taxonomy(id: "", name: "", color: "", logo: "", type: .OPONION)
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shadowView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //shadowView.dropShadow()
        
        
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)

        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 5
        shadowView.layer.masksToBounds = false

        
//        tableView.layer.shadowColor = #colorLiteral(red: 0.7922749113, green: 0.8017067554, blue: 0.8017067554, alpha: 1)
//        tableView.layer.shadowOpacity = 1
//        tableView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        tableView.layer.shadowRadius = 3
//        tableView.layer.masksToBounds = false
//
        
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        
        self.showSpinner(onView: self.view)
        taxonomy.type = .OPONION
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        //
        
        self.setupLoadMore()
        //
        // Do any additional setup after loading the view.
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
        self.loadArticles()
        if #available(iOS 13.0, *) {
                        self.setnavigationWhite_tintGray()
                    } else {
                        // Fallback on earlier versions
                    }
        
    }
}
extension ArticlesVC:UITableViewDataSource  {
    
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "OpenionPostCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
        cell?.parentViewController = self
        
        cell?.configureWithData(self.articles[indexPath.row])
        
        
        return cell!
    }
    
    
  
    
    
    
    
}
// MAK: - UITableDelegate
extension ArticlesVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var  title = ""
        if taxonomy.name != nil {
            title = taxonomy.name!
        }
        
        AppUtils.launchArticlesPagerController(articles: self.articles, index : indexPath.row, controller: self ,title:title)
        
    }
    
}
extension ArticlesVC {
    
    func loadArticles(){
        //tableView.windless.end()
        
      //  if Reachability.isConnectedToNetwork() == true {
            if(self.currentPage == 0)        {
                // AppUtils.showWait(self.tableView)
            }
            APIManager.getArticles(taxonomy: self.taxonomy, page: self.currentPage, suceess: { (articles:[Article]) in
                self.NetEror.isHidden = true

                self.removeSpinner()
                if self.currentPage == 0 &&  self.articles.count>0{ //pull to refresh
                    self.articles = []
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                    
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
                
                
                
                
                if(self.currentPage == 0)        {
                    self.tableView.reloadData()
                }
                else {
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: indexPaths, with: .none)
                    self.tableView.endUpdates()
                }
                
                
                
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
                    self.removeSpinner()
                    self.NetEror.isHidden = false

                   // self.showErrorView()
                }
                else{
                    self.removeSpinner()
                    self.shownoNetToast()
                  //  self.NetEror.isHidden = false

                }
            }
            
            
       // }
        /*else
        {
            self.removeSpinner()
            self.NetEror.isHidden = false
            //Realm
            
            //self.homeResponse = HomeResponseRealm.first
            //print(self.homeResponse)
            /*if( self.currentPage == 0){
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
            
            
            
            
        }
        */
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
