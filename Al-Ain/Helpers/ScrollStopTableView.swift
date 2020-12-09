//
//  ScrollStopTableView.swift
//  Al-Ain
//
//  Created by imac on 10/18/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
class ScrollStopTableView:UITableView{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isDecelerating{
            return self
        }
        return super.hitTest(point, with: event)
        
    }
 
}
