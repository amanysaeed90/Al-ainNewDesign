//
//  MenuItemCell.swift.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit


class MenuItemCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    var tax:Taxonomy!
    override func awakeFromNib() {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let buttonFont = UIFont.fontAwesome(ofSize: 25)
        
    }
    
   /* @IBAction func addBtnClick(_ sender: Any) {
        if MyTaxonomy.isTaxonomyInMyTaxonomies(tax){
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
    }*/
}
