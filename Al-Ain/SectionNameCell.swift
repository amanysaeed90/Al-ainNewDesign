//
//  SectionNameCell.swift
//  Al-Ain
//
//  Created by amany elhadary on 8/26/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher
class SectionNameCell: UICollectionViewCell {
    var section:Taxonomy?
    @IBOutlet weak var FavBtn: UIButton!
    @IBOutlet weak var SctionImage: RoundedCornerImage!
    @IBOutlet weak var sectionNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func objectExist (id: String) -> Bool {
        
        let realm = try! Realm()
        return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
    }
    func configureCell (Section:Taxonomy)
    {
        //  SctionImage.kf.setImage(with: URL(string:Section.!),options: [.transition(.fade(0.2))])
        section = Section
        let resource = ImageResource(downloadURL: URL(string:Section.logo!)!, cacheKey: Section.name)
        SctionImage.kf.setImage(with: resource)
        
        
        sectionNameLbl.text = Section.name
        
        let tax = MyTaxonomyies(Tax: Section)
        tax?.Tax = section
        print("///////////")
        print(tax as Any)
        if (self.objectExist(id: Section.id!))
        {
            self.FavBtn.setImage(UIImage(named: "stary"), for: .normal)
        }
        else {
            self.FavBtn.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
        }
        
    }
    
    @IBAction func FavAction(_ sender: UIButton) {
        let banner = Banner(title: "",subtitle:"RemoveFavoriteSection".localized(),  backgroundColor: UIColor.black)
        let banner2 = Banner(title: "",subtitle:"AddFavoriteSaction".localized() ,  backgroundColor: UIColor.black)

        if (self.objectExist(id: section!.id!))
        {
            banner2.dismiss()
            MyTaxonomy.save(self.section!)
            self.FavBtn.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
            banner.dismissesOnTap = true
            banner.show(duration: 4.0)
            
        }
        else {
                banner.dismiss()
            MyTaxonomy.save(self.section!)
            self.FavBtn.setImage(UIImage(named: "stary"), for: .normal)
            banner2.dismissesOnTap = true
            banner2.show(duration: 4.0)
            
        }
        
        
        
        
    }
   
}
