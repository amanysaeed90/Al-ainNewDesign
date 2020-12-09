//
//  MenuTableDelegat.swift
//  Al-Ain
//
//  Created by imac on 8/23/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
extension MoreTaxonomiesViewController: UITableViewDelegate  {
    
    // MARK: - Optional
    func Gettaxnomy (title: String) -> Taxonomy {
                                   
                let realm = try! Realm()
                let taxResult = realm.objects(Taxonomy.self).filter("name == %@", title)
                return taxResult.first!
            
             }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var   taxonomy:Taxonomy?  = nil
        taxonomy = (self.taxonmies[indexPath.row])
        let tax = self.Gettaxnomy(title: (taxonomy?.name!)!)
        
        
        if taxonomy != nil{
            FromTypeSection = true
            AppUtils.launchSectionViewController( taxonomy:tax , controller: RootViewController.shared!  )
        }
    }
}
