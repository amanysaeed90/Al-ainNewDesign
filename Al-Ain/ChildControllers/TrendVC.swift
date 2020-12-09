//
//  TrendVC.swift
//  Al-Ain
//
//  Created by al-ain nine on 9/30/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import ESPullToRefresh
import FontAwesome_swift
import UIKit
import RealmSwift
import DrawerMenu

class TrendVC: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    var taxonomy:Taxonomy!
    var articles:[Article] = []
    var currentPage = 0
    var  launchedAsStandAlone = false
    var SectionResponseRealm : Results<Article>! //[NotificationItems]()
    
    @IBOutlet weak var NetEror: WarningView!
    @IBOutlet weak var tableView: ScrollStopTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.showSpinner(onView: self.view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        self.setupLoadMore()
        self.registercell()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func registercell(){
        
        tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
        tableView.register(UINib(nibName: "OpenionPostCell", bundle: nil), forCellReuseIdentifier: "OpenionPostCell")
        tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: "VideoPostCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadArticles()
        DispatchQueue.main.async {
                         UIView.performWithoutAnimation {
                             let index = self.tableView.indexPathForSelectedRow
                             if (index != nil){
                                 self.tableView.reloadRows(at: [index!], with: UITableViewRowAnimation.automatic)
                             }
                         }
                     }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalPostCell", for: indexPath) as? PostCell
        cell?.parentViewController = self
        cell?.configureWithData(self.articles[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(articles[indexPath.row].nodeType == Article.BANNER_ARTICLE_TYPE ){
            
            let about = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            about.navigatToURL   =  URLRequest(url: URL(string: articles[indexPath.row].fullurl!)!)
            self.navigationController?.pushViewController(about, animated: true)
            
            return
        }
        var  title = ""
        if taxonomy.name != nil {
            title = taxonomy.name!
        }
        
        AppUtils.launchArticlesPagerController(articles: self.articles, index : indexPath.row, controller: self ,title:title)
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension TrendVC {
    
    func loadArticles(){
        //tableView.windless.end()
        
        
       // if Reachability.isConnectedToNetwork() == true {
            
            
            if(self.currentPage == 0)        {
                //AppUtils.showWait(self.tableView)
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
                    self.tableView.beginUpdates()
                    // self.tableView.deleteRows(at: indexPaths, with: .none)
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
                //self.setNeedsScrollViewInsetUpdate()
                if Reachability.isConnectedToNetwork() == false {
                    self.shownoNetToast()
                }
            }) { (error:Error?) in
                if(self.currentPage == 0)        {
                    self.NetEror.isHidden = false
                    self.removeSpinner()
                    
                }
                else{
                    self.shownoNetToast()
                }
            }
            
      //  }
      /*  else
        {
            //Realm
            
            //self.homeResponse = HomeResponseRealm.first
            //print(self.homeResponse)
            if( self.currentPage == 0){
                self.removeSpinner()
                self.NetEror.isHidden = false
                /*
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
                */
            }else{
                
                self.shownoNetToast()
                
            }
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
