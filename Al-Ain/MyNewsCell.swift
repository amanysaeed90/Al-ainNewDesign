//
//  MyNewsCell.swift
//  Al-Ain
//
//  Created by imac on 9/21/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation

import FontAwesome_swift
import UIKit


class MyNewsCell : UITableViewCell {
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
   // var tableView:UITableView!
    
    var index = -1
    override func awakeFromNib() {
        let buttonFont = UIFont.fontAwesome(ofSize: 25)
        deleteBtn!.titleLabel?.font = buttonFont
        deleteBtn!.setTitle(String.fontAwesomeIcon(name: .minusCircle), for: .normal)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        MyTaxonomy.myTaxonomies.remove(at: index)
      //  MyTaxonomy.save(<#T##taxItem: Taxonomy##Taxonomy#>)
     //   tableView!.reloadData()
     }
    
}
