//
//  TopicCell.swift
//  Al-Ain
//
//  Created by imac on 8/31/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit

class TopicCell : UITableViewCell {
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var tax:Taxonomy!
    override func awakeFromNib() {
        
        let buttonFont = UIFont.fontAwesome(ofSize: 25)
        
        addBtn!.titleLabel?.font = buttonFont
        addBtn!.setTitle(String.fontAwesomeIcon(name: .plusCircle), for: .normal)
        
    }
    
    @IBAction func addBtnClick(_ sender: Any) {
        if MyTaxonomy.isTaxonomyInMyTaxonomies(tax){
             
            MyTaxonomy.save(tax)
            let banner = Banner(title: "",subtitle:"هذا التصنيف مضاف بالفعل الي اختياراتك" ,  backgroundColor: UIColor.black)
            banner.dismissesOnTap = true
            banner.show(duration: 1.0)
            
            
        }else {
            MyTaxonomy.myTaxonomies.append(tax)
            MyTaxonomy.save(tax)
            let banner = Banner(title: "",subtitle:"تمت أضافة التصنيف بنجاح الي اختياراتك" ,  backgroundColor: UIColor.black)
            banner.dismissesOnTap = true
            banner.show(duration: 2.0)
            addBtn.isHidden = true
            
        }
    }
    
    
    
   
    
}
