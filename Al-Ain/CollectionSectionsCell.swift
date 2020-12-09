//
//  CollectionSectionsCell.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/8/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift
var FromTypeSection = false
class CollectionSectionsCell: UITableViewCell {

    
    @IBOutlet weak var CollectionTax: UICollectionView!
    var TaxResponse : Results<MyTaxonomyies>? //[NotificationItems]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionTax.delegate = self
        CollectionTax.dataSource = self
        CollectionTax.register(UINib(nibName: "FavCategorySectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FavCategorySectionCell")

        // Initialization code
    }
    
       func Gettaxnomy (title: String) -> Taxonomy {
                                  
               let realm = try! Realm()
               let taxResult = realm.objects(Taxonomy.self).filter("name == %@", title)
               return taxResult.first!
           
            }
       
    
    func set_delegate(){
               // CollectionTax.delegate = self
              // CollectionTax.dataSource = self
                let realm = try! Realm()
        TaxResponse = realm.objects(MyTaxonomyies.self)
                self.CollectionTax.reloadData()
               //CollectionTax.scrollsToTop = true
            if (TaxResponse!.count>0){
                CollectionTax.scrollToItem(at: IndexPath(row:0, section: 0), at: .right, animated: false)

                }
        TaxResponse?.reversed()
               // CollectionTax.contentOffset.x = 0

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CollectionSectionsCell:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let y =  TaxResponse![indexPath.row].Tax!
                        let sectiontext = y.name
        
                      let tax = self.Gettaxnomy(title: sectiontext!)
        
        FromTypeSection = true
        AppUtils.launchSectionViewController( taxonomy:y , controller: RootViewController.shared! )
        
    }
    
}

extension CollectionSectionsCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  TaxResponse?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavCategorySectionCell", for: indexPath) as! FavCategorySectionCell
        
        print("TaxIn Cell is \(TaxResponse![indexPath.row].Tax!)")
        
       
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        cell.configureCellTax(Section: TaxResponse![indexPath.row].Tax!)


               return cell
    }
    
    
}
extension CollectionSectionsCell : UICollectionViewDelegateFlowLayout
{
   
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
       // let xx = ( Double(width) * 0.50 ) - 25
        return CGSize(width: Int( 90) , height: Int( 127) )
     
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
}
