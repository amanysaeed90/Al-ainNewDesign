//
//  HomePageViewController + loadData.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Firebase
import Toast_Swift
import RealmSwift
//import SwiftOverlays
import LoadingShimmer

extension HomePageViewController {
    
    func loadHome(){
        NetEror.isHidden = true

        UIFont.familyNames.forEach({ familyName in
      let fontNames = UIFont.fontNames(forFamilyName: familyName)
      print(familyName, fontNames)
              })
        
        print("-----------------realm file-----------------------------------------")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        print(Realm.Configuration.defaultConfiguration.schemaVersion)
      
       // if Reachability.isConnectedToNetwork() == true {
        

        APIManager.getHome( page:self.currentPage,suceess: { (homeResponse:HomeResponse) in
            self.removeSpinner()
            if( self.currentPage == 0){
                self.homeResponse  = homeResponse
                self.homeResponse.latestNews.removeLast()
//                do {
//                let realm = try Realm()
//                try realm.write {
//                     realm.add(homeResponse,update: true)
//                }
//                }
//                catch let error as NSError {
//                }
                self.numberOfTableViewSections =  2  + (homeResponse.featuredInSection.count)
                self.latestInHome = self.numberOfTableViewSections - 1
               // SwiftOverlays.removeAllBlockingOverlays()

                DispatchQueue.main.async {
                                   self.tableView.reloadData()
                                   }
                
            }else{
                
                var newArticles:[Article] = Array(homeResponse.latestNews) as [Article]
                if(newArticles.count < APIManager.MAX_COUNT){ // no more data available
                    self.tableView.es_noticeNoMoreData()
                }
                
                newArticles.removeLast()
                let newArticlesCount = newArticles.count
                let olderCount = self.homeResponse.latestNews.count
                self.homeResponse.latestNews.append(objectsIn: newArticles)
                
                
                
//                do {
//
//
//
//                    try! self.realm.write {
//               // self.homeResponse.latestNews.removeAll()
//                        self.realm.add(homeResponse,update: true)
//                        self.realm.add(homeResponse.latestNews,update: true)
//
//                self.homeResponse.latestNews.append(objectsIn: newArticles)
//                }
//                }
//                catch let error as NSError {
//                    print(error)
//                }
                var indexPaths = [IndexPath]()
                for i in 0..<newArticlesCount {
                    indexPaths.append(IndexPath(row: olderCount + i, section:self.numberOfTableViewSections - 1))
                }
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .none)
                self.tableView.endUpdates()
                
            }
            self.tableView.es_stopPullToRefresh()
            self.tableView.es_stopLoadingMore()
            if Reachability.isConnectedToNetwork() == false {
                self.shownoNetToast()
            }
           // LoadingShimmer.stopCovering(self.tableView)

           // SwiftOverlays.removeAllBlockingOverlays()

        }) { (error:Error?) in
            self.removeSpinner()
         //  self.showErrorView()
          //  self.NetEror.isHidden = false

            if( self.currentPage != 0){
            self.shownoNetToast()
            }
            else
            {
                  self.NetEror.isHidden = false

            }
        }
      //  }
      /*  else
        {
             self.removeSpinner()
            self.NetEror.isHidden = false

            //Realm
         
            //self.homeResponse = HomeResponseRealm.first
            //print(self.homeResponse)
            if( self.currentPage == 0){
                let realm = RealmService.shared.realm
                // notificationItems = realm.objects(NotificationItems.self)
                HomeResponseRealm = realm.objects(HomeResponse.self)//.sorted(byKeyPath: "Date", ascending: false)
                self.homeResponse = HomeResponseRealm.first
                do {
                    let realm = try Realm()

                try! realm.write {
                // self.homeResponse.latestNews.removeLast()
                }
             
                }
                catch let error as NSError {
                }
               // self.numberOfTableViewSections =  2  + (homeResponse.featuredInSection.count)
               // self.latestInHome = self.numberOfTableViewSections - 1
                DispatchQueue.main.async {
                                   self.tableView.reloadData()
                                   }
            }else{
                
                  self.shownoNetToast()
                
            }
            self.tableView.es_stopPullToRefresh()
            self.tableView.es_stopLoadingMore()
           

            
            
        }
    */
    
    }
    
    
    
    func getArticle(indexPath: IndexPath) -> Article{
        
        let articles = getArticles(section: indexPath.section)
        var articleww = Array(articles)
        
        var articel = articleww[indexPath.row]
        return articles[indexPath.row]
        
        
    }
    
    
    func getArticles( section: Int) -> [Article]{
        var ReturnedArticle : [Article] = [Article]()
        
        switch section {
        case featuredInHome:
            
            let List :List<Article> = homeResponse.featuredInHome
            
            
            for item in List
            {
                ReturnedArticle.append(item)
            }

            return ReturnedArticle
        case videosInHome:
            let List = Array(homeResponse.videos)
            for item in List
            {
                ReturnedArticle.append(item)
            }
            return ReturnedArticle
        case latestInHome:
            let List = Array(homeResponse.latestNews)
            for item in List
            {
                ReturnedArticle.append(item)
            }
            return ReturnedArticle
            
        default:
            var ReturnedArticle : [FeaturedInSection] = [FeaturedInSection]()
            var ReponseArray = Array(homeResponse.featuredInSection)
            for item in ReponseArray
            {
                ReturnedArticle.append(item)
            }
            var specialArticle = ReturnedArticle[section - 1]
            var customArr : [Article] = [Article]()
             customArr = Array(specialArticle.nodes)
            
            return customArr
            
        }
        
    }
    
    func addPullToRefresh(){
        self.tableView.es_addPullToRefresh {
            [unowned self] in
            self.currentPage  =  0
            self.loadHome()
        }
        
        self.tableView.es_addInfiniteScrolling {
            [unowned self] in
            self.currentPage += 1
            self.loadHome()
        }
        
    }
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(self.retry));
    }
    
    @objc func retry (_ sender: UIGestureRecognizer){
        AppUtils.removeWait(view)
        self.loadHome()
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



extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
