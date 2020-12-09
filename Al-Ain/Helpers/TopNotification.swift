//
//  TopNotification.swift
//  Al-Ain
//
//  Created by imac on 9/4/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
class  TopNotification: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var NewsTypeLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    var articleId = ""
    
    override func awakeFromNib() {
        contentView.layer.cornerRadius = 5
    }
    
    @IBAction func openArticle(_ sender: Any) {
        
        if(articleId != "")
        {
            AppUtils.launchSingleArticleView(articleId: articleId, controller: RootViewController.shared! )
            
        }
        self.isHidden = true
    }
}
