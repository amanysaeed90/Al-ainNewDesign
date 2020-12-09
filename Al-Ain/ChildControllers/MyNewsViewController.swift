//
//  HomePageViewController
//  Al-Ain
//
//  Created by imac on 8/30/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import AlgoliaSearch
import FontAwesome_swift

class MyNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: ScrollStopTableView!
    @IBOutlet weak var emptyMyNews: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    var currentPage = 0
    let featuredCellIdentifier = "FeaturedPostCell"
    let cellTypeIDs = [
        Article.NEWS_ARTICLE_TYPE: "NormalPostCell",
        Article.VIDEO_ARTICLE_TYPE: "VideoPostCell",
        Article.OPINION_ARTICLE_TYPE: "OpenionPostCell",
        Article.BANNER_ARTICLE_TYPE: "BannerPostCell"

    ]
    
    let featuredInHome = 0
    let videosInHome = 1
    var latestInHome = 3
    let featuredInSetion = 2
    var numberOfTableViewSections = 0
    var hidingNavBarManager: HidingNavigationBarManager?

    
    var articlesHits: [JSONObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonFont = UIFont.fontAwesome(ofSize: 30)
        
        addButton!.titleLabel?.font = buttonFont
        addButton!.setTitle(String.fontAwesomeIcon(name: .plusCircle), for: .normal)
        addButton.addTarget(RootViewController.shared, action: #selector(RootViewController.shared?.openMenu), for: .touchDown)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300 
        self.addPullToRefresh()
        self.hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: tableView)
       // self.hidingNavBarManager?.addExtensionView(self.tabmanBar!)
        
     }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidingNavBarManager?.viewDidLayoutSubviews()
      
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hidingNavBarManager?.viewWillDisappear(animated)
      
        
    }
    
    // MARK: UITableViewDelegate
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
       
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)

        if MyTaxonomy.myTaxonomies.count == 0 {
            emptyMyNews.isHidden = false
            articlesHits = []
            tableView.reloadData()
        } else {
            emptyMyNews.isHidden = true
            loadMyNews()
        }
    }
    
 
    
}


