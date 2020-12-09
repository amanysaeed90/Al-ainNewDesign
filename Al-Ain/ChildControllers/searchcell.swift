//
//  searchcell.swift
//  RecipeTask
//
//  Created by mac on 10/4/18.
//  Copyright © 2018 amany. All rights reserved.
//

import UIKit

class searchcell: UITableViewCell {

    @IBOutlet weak var searchtext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var textsearch : String? {
        didSet {
            if let textsearch_ = textsearch {
            searchtext.text = textsearch_
            }
        }
        
    }
    
}
