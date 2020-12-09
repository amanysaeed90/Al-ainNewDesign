//
//  FavCategorySectionCell.swift
//  Al-Ain
//
//  Created by al-ain nine on 10/8/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

class FavCategorySectionCell: UICollectionViewCell {
     var section:Taxonomy?
      //  @IBOutlet weak var FavBtn: UIButton!
        @IBOutlet weak var SctionImage: RoundedCornerImage!
        @IBOutlet weak var sectionNameLbl: UILabel!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
      
        func configureCellTax (Section:Taxonomy)
        {
            self.section = Section

            if let urlImg = self.section?.logo {
            SctionImage.kf.setImage(with: URL(string:urlImg),options: [.transition(.fade(0.2))])
            }
            else
            {
                SctionImage.image = UIImage(named: "DefaultSectionImg")
            }
            sectionNameLbl.text = Section.name
         
                                          let tax = MyTaxonomyies(Tax: Section)
                                         tax?.Tax = section
                                         print("///////////")
                                         print(tax as Any)
//                                        if (self.objectExist(id: Section.id!))
//                                         {
//                                          self.FavBtn.setImage(UIImage(named: "stary"), for: .normal)
//                                         }
//                                         else {
//                                            self.FavBtn.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
//                                         }
                       
        }

//        @IBAction func FavAction(_ sender: UIButton) {
//
//                                              if (self.objectExist(id: section!.id!))
//                                               {
//                                                 MyTaxonomy.save(self.section!)
//                                                self.FavBtn.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
//
//
//                                              }
//                                               else {
//                                                MyTaxonomy.save(self.section!)
//                                                self.FavBtn.setImage(UIImage(named: "stary"), for: .normal)
//
//
//                                               }
//
//
//
//
//        }
    }
