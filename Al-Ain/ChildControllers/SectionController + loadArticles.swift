//
//  SectionController + loadArticles.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import  UIKit
//import RealmSwift
//import Realm
import LoadingShimmer
extension SectionController {
    
    func loadArticles(){
        //tableView.windless.end()
        
        if (self.OpenionArticleID == 0){
          //  if Reachability.isConnectedToNetwork() == true {
                self.NetEror.isHidden = true
                if(self.currentPage == 0)        {
                //AppUtils.showWait(self.tableView)
                // checkOffsetToChangeNavColor()
                        }
                
                if (FromTypeSection == false ){
                    // Load Section Data
                    print(self.taxonomy)
                    APIManager.getArticles(taxonomy: self.taxonomy, page: self.currentPage, suceess: { (articles:[Article]) in
                        
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
                        
//                        do{
//                            let realm = try Realm()
//                            try realm.write {
//                                realm.add(newArticles,update: true)
//                            }
//                        }
//                        catch let error as NSError {
//                        }
                        var indexPaths = [IndexPath]()
                        for i in 0..<newArticlesCount {
                            indexPaths.append(IndexPath(row: olderCount + i, section: 0))
                        }
                        
                        
                        self.NetEror.isHidden = true
                        
                        if(self.currentPage == 0)        {
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()
                            }
                        }
                        else {
                            self.tableView.beginUpdates()
                            
                            //  self.tableView.deleteRows(at: indexPaths, with: .none)
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
                            // self.shownoNetToast()
                        }
                    }) { (error:Error?) in
                        if(self.currentPage == 0)        {
                            
                            self.removeSpinner()
                            self.NetEror.isHidden = false
                            
                        }
                        else{
                            self.removeSpinner()
                            self.shownoNetToast()
                        }
                    }
                }
                else
                {
                    // Load section data from pages .. counteries .. etc
                    
                    APIManager.getArticlesPages(taxonomy: self.taxonomy, page: self.currentPage, suceess: { (articles:[Article]) in
                        
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
                        
//                        do{
//                            let realm = try Realm()
//                            try realm.write {
//                                realm.add(newArticles,update: true)
//                            }
//                        }
//                        catch let error as NSError {
//                        }
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
                            
                            //  self.tableView.deleteRows(at: indexPaths, with: .none)
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
                            // self.shownoNetToast()
                        }
                    }) { (error:Error?) in
                        if(self.currentPage == 0)        {
                            
                            self.removeSpinner()
                            // self.showErrorView()
                        }
                        else{
                            self.removeSpinner()
                            //self.shownoNetToast()
                        }
                    }
                    
                }
          //  }
           /* else
            {
                //Realm
                self.removeSpinner()
                
                if (articles.count == 0){
                    self.NetEror.isHidden = false
                }
                
                //self.homeResponse = HomeResponseRealm.first
                //print(self.homeResponse)
                /* if( self.currentPage == 0){
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
        else
        {
            if Reachability.isConnectedToNetwork() == true {
                
                self.NetEror.isHidden = true
                self.removeSpinner()
                if(self.currentPage == 0)        {
                    //AppUtils.showWait(self.tableView)
                }
                APIManager.getArticlesOpenion(taxonomy: self.taxonomy, page: self.currentPage, suceess: { (articles:[Article]) in
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
                        self.tableView.insertRows(at: indexPaths, with: .none)
                        self.tableView.endUpdates()
                    }
                    
                    
                    
                    if(self.currentPage == 0)        {
                        AppUtils.removeWait(self.view)
                    }
                    
                    self.tableView.es_stopPullToRefresh()
                    self.tableView.es_stopLoadingMore()
                 //   self.setNeedsScrollViewInsetUpdate()
                    if Reachability.isConnectedToNetwork() == false {
                        self.shownoNetToast()
                    }
                }) { (error:Error?) in
                    if(self.currentPage == 0)        {
                        //self.showErrorView()
                        self.removeSpinner()
                        self.NetEror.isHidden = false
                        
                    }
                    else{
                        self.shownoNetToast()
                    }
                }
                
            }
            
            
        }
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
