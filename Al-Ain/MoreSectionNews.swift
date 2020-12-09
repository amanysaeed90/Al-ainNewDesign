//
//  MoreSectionNews.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/29/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import Localize_Swift

class MoreSectionNews: UITableViewCell {
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl.text = "More".localized()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
