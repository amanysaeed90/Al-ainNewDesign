//
//  MenuItemHeader.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import LUExpandableTableView
import FontAwesome_swift

final class MenuItemHeader : LUExpandableTableViewSectionHeader {
    // MARK: - Properties
    
    @IBOutlet weak var expandCollapseButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override var isExpanded: Bool {
        didSet {
            // Change the title of the button when section header expand/collapse
             expandCollapseButton!.setTitle(String.fontAwesomeIcon(name:isExpanded ? .angleUp: .angleDown), for: .normal)
//            if (isExpanded == true){
//            expandCollapseButton!.setImage(#imageLiteral(resourceName: "Group 803"), for: .normal)
//            }
//            else
//            {
//            expandCollapseButton!.setImage(#imageLiteral(resourceName: "Group 804"), for: .normal)
//
//            }
        }
    }
    
    // MARK: - Base Class Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel)))
        label?.isUserInteractionEnabled = true
        label?.textColor = UIColor.black
        let buttonFont = UIFont.fontAwesome(ofSize: 30)
        label.font = Fonts.getFontSelected(fontSize: 15)
       // expandCollapseButton!.titleLabel?.font = buttonFont
       // expandCollapseButton!.setTitle(String.fontAwesomeIcon(name: .sortDesc), for: .normal)
       // expandCollapseButton!.setImage(#imageLiteral(resourceName: "Group 804"), for: .normal)

        
        
    }
    
    // MARK: - IBActions
    
    @IBAction func expandCollapse(_ sender: UIButton) {
        // Send the message to his delegate that shold expand or collapse
        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
    
    }
    
    // MARK: - Private Functions
    
    @objc func didTapOnLabel(_ sender: UIGestureRecognizer) {
        // Send the message to his delegate that was selected
        delegate?.expandableSectionHeader(self, wasSelectedAtSection: section)
    }
}
