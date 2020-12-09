//
//  HeaderTitleCell.swift
//  Al-Ain
//
//  Created by imac on 8/31/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import Localize_Swift

class HeaderTitleCell : UITableViewHeaderFooterView {
    @IBOutlet weak var TopConstrain: NSLayoutConstraint!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    var sectionInfo:Info!
    var isVideo:Bool = false
    
    @IBOutlet weak var TopConstarintcolorview: NSLayoutConstraint!
    @IBOutlet weak var BottonConstarintcolorview: NSLayoutConstraint!

    @IBOutlet weak var ColorView: UIView!
    @IBOutlet weak var sparetorUp: UIView!
    
    override func awakeFromNib() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{
            title.textAlignment = .left
            if #available(iOS 13.0, *) {
                arrow.image = UIImage(systemName: "chevron.left")
                arrow.transform = CGAffineTransform(scaleX: -1, y: 1)

//                arrow.image = UIImage(systemName: "chevron.forward")
            } else {
                // Fallback on earlier versions
            }

        }
        else
        {
            // fa // ar
            title.textAlignment = .right
            if #available(iOS 13.0, *) {
                arrow.image = UIImage(systemName: "chevron.left")
            } else {
                // Fallback on earlier versions
            }

        }
       
    }
 
    func showArrow() {
        
//        if arrow.image == nil
//        {
//            arrow.image = UIImage.fontAwesomeIcon(name: .angleLeft, textColor: Colors.accentColor,size: CGSize(width: 30, height: 30))
//        }
        arrow.isHidden = false
        
    }
    func  hideArrow(){
        arrow.isHidden = true
        
    }
    
    
    
    @objc func  goToSection(_ sender: UIGestureRecognizer)  {
        if(sectionInfo != nil){
            
            let taxonomy = Taxonomy()
            taxonomy.type = .SECTION
            taxonomy.name = sectionInfo.title
            taxonomy.id = sectionInfo.id!
            SectionFromMenu = false
            AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: TabBaController.Shared!  )
            
            
        }else if isVideo{
            
            let taxonomy = Taxonomy()
            
            taxonomy.name = "فيديو"
            taxonomy.type = .VIDEO
            SectionFromMenu = false

              AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: RootViewController.shared!  )
            
        }
    }
    
}
