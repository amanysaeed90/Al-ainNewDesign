//
//  MenuTableDataSource.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit

extension MoreTaxonomiesViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxonmies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MenuItemCell else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        
        
        if MyTaxonomy.isTaxonomyInMyTaxonomies(self.taxonmies[indexPath.row]){
            //cell.addBtn.isHidden = true
        }else {
           // cell.addBtn.isHidden = false
       cell.tax = (self.taxonmies[indexPath.row])
            
        }
        cell.label.text = (self.taxonmies[indexPath.row]).name!
        return cell
    }
    
    
    
    
}
