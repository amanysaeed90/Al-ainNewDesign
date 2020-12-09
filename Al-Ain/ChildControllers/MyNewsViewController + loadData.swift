//
//  HomePageViewController + loadData.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Firebase
import AlgoliaSearch
import RealmSwift
import Realm

extension MyNewsViewController {
    
    func loadMyNews(){
        if MyTaxonomy.myTaxonomies.count == 0 {
            emptyMyNews.isHidden = false
            return
        }
        emptyMyNews.isHidden = true
        
        
        if(self.currentPage == 0){
          //  AppUtils.showWait(self.view)
        }
        APIManager.getMyNews( page:self.currentPage,suceess: { (results:[JSONObject]) in
            if( self.currentPage == 0){
                self.articlesHits  = results
                self.tableView.reloadData()
            }else{
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
                self.showErrorView()
            }
            else{
                self.shownoNetToast()
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


