//
//  FavoritesVC.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/8/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import AlgoliaSearch
import RealmSwift
import Realm


final class FavoritesVC: UIViewController {
    @IBOutlet weak var tableView: ScrollStopTableView!
    @IBOutlet weak var emptyMyNews: WarningView!
    @IBOutlet weak var NetEror: WarningView!
    
    open var currentPage = 0
    let cellTypeIDs = [
        Article.NEWS_ARTICLE_TYPE: "NormalPostCell",
        Article.VIDEO_ARTICLE_TYPE: "VideoPostCell",
        Article.OPINION_ARTICLE_TYPE: "OpenionPostCell",
        
    ]
    var articlesHits: [JSONObject] = []
    var TaxResponseRealm : Results<MyTaxonomyies>! //[NotificationItems]()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("FavoritesVC View Controller Will Disappear")
    }
    var first = 0
    override func viewWillAppear(_ animated: Bool) {
        //self.LoadingView.isHidden = false
        print("FavoritesVC View Controller Will Appear")

        //
        if (first == 0){
     //   self.showSpinnerClear(onView: self.view)
        }
        else
        {
            first = 1
        }
        self.GetMYtaxonmiesRealm()
        emptyMyNews.HeaderText = "NoFavoriteNews".localized()
        emptyMyNews.DescriptionText = "AllFavoriteNewsHere".localized()
        emptyMyNews.ImgName = "NoFav"
        NetEror.isHidden = true
        NetEror.ImgName = "noInternet"
        NetEror.HeaderText = "NetWorkFailed".localized()
        NetEror.DescriptionText = "NetWorkFailedDescription".localized()
        NetEror.tryagainbtn.isHidden = false
        NetEror.tryagainbtn.addTarget(self, action: #selector(retryGetData), for: .touchUpInside)
        if TaxResponseRealm.count == 0 {
            emptyMyNews.isHidden = false
            articlesHits = []
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        } else {
            emptyMyNews.isHidden = true
            loadMyNews()
            
        }
        
        
    }
    
    @objc func retryGetData (){
             //  self.showSpinnerClear(onView: self.view)
               self.loadMyNews()
                 
             }

    func registercell(){
        
        tableView.register(UINib(nibName: "NormalPostCell", bundle: nil), forCellReuseIdentifier: "NormalPostCell")
        tableView.register(UINib(nibName: "OpenionPostCell", bundle: nil), forCellReuseIdentifier: "OpenionPostCell")
        tableView.register(UINib(nibName: "VideoPostCell", bundle: nil), forCellReuseIdentifier: "VideoPostCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.showSpinner(onView: self.view)

        self.registercell()
        self.addPullToRefresh()
        self.GetMYtaxonmiesRealm()

        
        // Do any additional setup after loading the view.
    }
    
    func GetMYtaxonmiesRealm(){
        let realm = try! Realm()
        //return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
        TaxResponseRealm = realm.objects(MyTaxonomyies.self)
        
        
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
extension FavoritesVC:UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return (articlesHits.count + 2)

        return (articlesHits.count )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId:String
        
       /* if(indexPath.row == 0 ){
            cellId = "CollectionSectionsCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CollectionSectionsCell
            cell?.CollectionTax.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            
            cell?.set_delegate()
            if (TaxResponseRealm.count > 0){
                cell?.CollectionTax.scrollToItem(at: IndexPath(row:0, section: 0), at: .right, animated: false)
            }
            // cell?.TaxResponse = TaxResponseRealm
            // cell?.CollectionTax.reloadData()
            //cell?.CollectionTax.layoutIfNeeded()
            cell?.contentView.alpha = 0
            
            return cell!
            
        }elseif (indexPath.row == 0){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderFiltterCell", for: indexPath) as? FilterCell
            cell?.contentView.alpha = 0
            cell?.parentVC = self
            cell?.UpdateArray()
            return cell!
            
        }
        else
        {*/
            cellId = cellTypeIDs[Article.NEWS_ARTICLE_TYPE]!
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostCell
            if (TaxResponseRealm.count > 0){
                //cell?.configureWithData(articlesHits[indexPath.row - 2])
                cell?.configureWithData(articlesHits[indexPath.row])
                cell?.ArticleID = articlesHits[indexPath.row]["objectID"] as? String

               // cell?.ArticleID = articlesHits[indexPath.row-2]["objectID"] as! String
            }
            cell?.contentView.alpha = 1
            cell?.parentViewController = self
            
            return cell!
      //  }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        UIView.animate(withDuration: 0.2, animations: {
         //   cell.contentView.alpha = 1.0
        })
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if(indexPath.row == 0  ){
//            return 188
//        }else if (indexPath.row == 1)
//        {
//            return 46
//
//        }
//        else {
            
            return 130
//        }
    }
    
}
extension FavoritesVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (TaxResponseRealm.count > 0){
//            if ((indexPath.row > 1))
//            {
                AppUtils.launchSingleArticleView (articleId:  articlesHits[indexPath.row]["objectID"] as! String ,controller: self)
//            }
            
        }
        
    }
}
// GET DATA
extension FavoritesVC{
    
    func loadMyNews(){
        NetEror.isHidden = true

        //         if MyTaxonomy.myTaxonomies.count == 0 {
        //             emptyMyNews.isHidden = false
        //             return
        //         }
        //         emptyMyNews.isHidden = true
        //
        //
        if(self.currentPage == 0){
            //  AppUtils.showWait(self.view)
        }
        APIManager.getMyNews( page:self.currentPage,suceess: { (results:[JSONObject]) in
            //
            
            self.removeSpinner()
            if( self.currentPage == 0){
                
                self.articlesHits  = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //  self.LoadingView.isHidden = true
                    
                }             }else{
                if !results.isEmpty
                {
                    
                    
                    var newArticles = results
                    
                    newArticles.removeLast()
                    let newArticlesCount = newArticles.count
                    
                    let olderCount = self.articlesHits.count
                    self.articlesHits.append(contentsOf: newArticles)
                    
                    
                    var tempArticles : [Article] = [Article]()
                    for item in newArticles {
                        let article = Article(JSON: item)
                        if let ar = article {
                            tempArticles.append(ar)
                        }
                        
                    }
//                    do{
//                        let realm = try Realm()
//                        try realm.write {
//                            realm.add(tempArticles,update: true)
//                        }
//                    }
//                    catch let error as NSError {
//                        print(error)
//                         self.removeSpinner()
//                    }
                    
                    
                    
                    var indexPaths = [IndexPath]()
                    for i in 0..<newArticlesCount {
                        indexPaths.append(IndexPath(row: olderCount + i, section: 0))
                    }
                    
                    
                    
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: indexPaths, with: .none)
                    self.tableView.endUpdates()
                    
                    
                    
                }
            }
            self.tableView.es_stopPullToRefresh()
            self.tableView.es_stopLoadingMore()
            
            
            AppUtils.removeWait(self.view)
           
            
        }) { (error:Error?) in
            if (self.currentPage == 0 )
            {
                //self.showErrorView()
                self.NetEror.isHidden = false
                self.removeSpinner()
            }
            else{
                self.shownoNetToast()
                self.removeSpinner()
            }
        }
    }
    func loadMyNewsFiltter(Object : [AnyObject]){
        NetEror.isHidden = true
        //self.showSpinnerClear(onView: self.tableView)
        
           //         if MyTaxonomy.myTaxonomies.count == 0 {
           //       emptyMyNews.isHidden = false
           //             return
           //         }
           //         emptyMyNews.isHidden = true
           //
           //
           if(self.currentPage == 0){
               //  AppUtils.showWait(self.view)
           }
           APIManager.getMyNewsFilter( page:self.currentPage,object: Object,suceess: { (results:[JSONObject]) in
               //
               
               self.removeSpinner()
               if( self.currentPage == 0){
                   
                   self.articlesHits  = results
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                       
                   }             }else{
                   if !results.isEmpty
                   {
                       
                       
                       var newArticles = results
                       
                       newArticles.removeLast()
                       let newArticlesCount = newArticles.count
                       
                       let olderCount = self.articlesHits.count
                       self.articlesHits.append(contentsOf: newArticles)
                       
                       
                       var tempArticles : [Article] = [Article]()
                       for item in newArticles {
                           let article = Article(JSON: item)
                           if let ar = article {
                               tempArticles.append(ar)
                           }
                           
                       }
                       do{
                           let realm = try Realm()
                           try realm.write {
                               realm.add(tempArticles,update: true)
                           }
                       }
                       catch let error as NSError {
                           print(error)
                            self.removeSpinner()
                       }
                       
                       
                       
                       var indexPaths = [IndexPath]()
                       for i in 0..<newArticlesCount {
                           indexPaths.append(IndexPath(row: olderCount + i, section: 0))
                       }
                       
                       
                       
                       self.tableView.beginUpdates()
                       self.tableView.insertRows(at: indexPaths, with: .none)
                       self.tableView.endUpdates()
                       
                       
                       
                   }
               }
               self.tableView.es_stopPullToRefresh()
               self.tableView.es_stopLoadingMore()
               
               
               AppUtils.removeWait(self.view)
               if Reachability.isConnectedToNetwork() == false {
                   self.shownoNetToast()
               }
               
           }) { (error:Error?) in
               if (self.currentPage == 0 )
               {
                   //self.showErrorView()
                   self.NetEror.isHidden = false
                   self.removeSpinner()
               }
               else{
                   self.shownoNetToast()
                   self.removeSpinner()
               }
           }
       }
    func addPullToRefresh(){
        self.tableView.es_addPullToRefresh {
            [unowned self] in
            self.currentPage  =  0
            self.loadMyNews()
        }
        
        self.tableView.es_addInfiniteScrolling {
            [unowned self] in
            self.currentPage += 1
            self.loadMyNews()
        }
        
    }
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(self.retry));
    }
    
    @objc func retry (_ sender: UIGestureRecognizer){
        AppUtils.removeWait(view)
        self.loadMyNews()    }
    
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
