//
//  MyNewsEditViewController.swift
//  Al-Ain
//
//  Created by imac on 9/21/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
class MyNewsEditViewController :UITableViewController
{
    override func viewDidLoad() {
        
        title = "إختياراتي"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return   MyTaxonomy.myTaxonomies.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? MyNewsCell
        cell?.topicTitle.text = MyTaxonomy.myTaxonomies[indexPath.row].name
       // cell?.tableView = tableView
        cell?.index = indexPath.row
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SectionFromMenu = false

        AppUtils.launchSectionViewController( taxonomy:MyTaxonomy.myTaxonomies[indexPath.row] , controller: RootViewController.shared!  )
        
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scriolling .. ")
        self.tableView.hideAllToasts()
        self.tableView.clearToastQueue()
    }
}
