//
//  FilterCell.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/10/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift
class FilterCell: UITableViewCell {
        @IBOutlet weak var FiltterBtn: UIButton!
        @IBOutlet weak var FilterLbl: UILabel!
        let dropDown = DropDown()
        var TaxResponseRealm : Results<MyTaxonomyies>! //[NotificationItems]()
    var parentVC:FavoritesVC?

    override func awakeFromNib() {
        super.awakeFromNib()
        
            // Initialization code
            let realm = try! Realm()
            //return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
            TaxResponseRealm = realm.objects(MyTaxonomyies.self)
                var myTaxonomiesArray:[String] = []
                myTaxonomiesArray.append("الكل")
              for item in TaxResponseRealm
              {
                  myTaxonomiesArray.append(item.Tax!.name!)
              }
              dropDown.bottomOffset = CGPoint(x: 0, y: FiltterBtn.bounds.height)

                dropDown.anchorView = FiltterBtn // UIView or UIBarButtonItem
               dropDown.dataSource = myTaxonomiesArray
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   print("Selected item: \(item) at index: \(index)")
                   self.FilterLbl.text = item
                    //self.tableView.reloadData()
                    self.dropDown.hide()
               }
    }
    func UpdateArray () {
        
        let realm = try! Realm()
                  //return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
                  TaxResponseRealm = realm.objects(MyTaxonomyies.self)
                  var myTaxonomiesArray:[String] = []
                    myTaxonomiesArray.append("الكل")
                    for item in TaxResponseRealm
                    {
                        myTaxonomiesArray.append(item.Tax!.name!)
                    }
                    dropDown.bottomOffset = CGPoint(x: 0, y: FiltterBtn.bounds.height)

                    dropDown.anchorView = FiltterBtn // UIView or UIBarButtonItem
                     dropDown.dataSource = myTaxonomiesArray
                     dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                         print("Selected item: \(item) at index: \(index)")
                         self.FilterLbl.text = item
                         self.parentVC?.currentPage = 0
                        if (item != "الكل"){
                            let taxResult = realm.objects(Taxonomy.self).filter("name == %@", item)
                            let taxRsul=taxResult.first!
                            var newUploadFilesArray = [AnyObject]()
                            let ObjectFiltter = ["name" : taxRsul.name , "type" : taxRsul.taxType , "id" : taxRsul.id]
                            newUploadFilesArray.append(ObjectFiltter as AnyObject)
                            self.parentVC?.loadMyNewsFiltter(Object: newUploadFilesArray)
                        }
                        else
                        {
                             self.parentVC?.loadMyNews()
                        }
                         
                        self.dropDown.hide()
                     }
        
        
    }
    @IBAction func FiltterBtnAction(_ sender: Any) {
           dropDown.show()
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
