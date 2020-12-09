//
//  SectionController + loadTaxonmies.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import  UIKit
import RealmSwift
import Realm

extension MoreTaxonomiesViewController {
    func loadTaxonomies(){
        if(self.currentPage == 0)        {
           // AppUtils.showWait(self.tableView)
        }
        APIManager.getMoreTaxonimies(taxonomyType, page: self.currentPage, suceess: { (taxonmies:List<Taxonomy>) in
            
            
            if self.currentPage == 0 &&  self.taxonmies.count>0{ //pull to refresh
                self.taxonmies = []
                self.tableView.reloadData()
            }
            
            
            var newTaxonmies = taxonmies
            if(taxonmies.count < APIManager.MAX_COUNT){ // no more data available
                self.tableView.es_noticeNoMoreData()
            }else{
                newTaxonmies.removeLast()
            }
            let newTaxonmiesCount = newTaxonmies.count
            
            let olderCount = self.taxonmies.count
            self.taxonmies.append(contentsOf: newTaxonmies)
            
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(newTaxonmies,update: true)
                }
            }
            catch let error as NSError {
            }
            
            
            
            var indexPaths = [IndexPath]()
            for i in 0..<newTaxonmiesCount {
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
            
        }) { (error:Error?) in
            if(self.currentPage == 0)        {
                 self.showErrorView()
            }
        }
    }
    
    func setupLoadMore(){
        
        
        self.tableView.es_addInfiniteScrolling {
            [weak self] in
            self?.currentPage += 1
            self?.loadTaxonomies()
        }
    }
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(retry));
    }
    
    
    @objc func retry (_ sender: UIGestureRecognizer){
        //AppUtils.showWait(self.view)
        
        self.loadTaxonomies()
        
    }

}
