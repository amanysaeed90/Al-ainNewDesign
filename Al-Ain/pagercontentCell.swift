//
//  pagercontentCell.swift
//  Al-Ain
//
//  Created by amany elhadary on 4/24/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift

class pagercontentCell: UICollectionViewCell {
    var artice:Article?
    @IBOutlet weak var newsTimelbl: UILabel!
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var newsTypeLbl: UILabel!
    @IBOutlet weak var conteainerImage: UIView!
    @IBOutlet weak var PageImage: UIImageView!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var Sectionlbl: RoundedCornerLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initializat  ion code
          layoutView()
            newsTypeLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
            newsTypeLbl.isUserInteractionEnabled = true
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            newsTitleLbl.textAlignment = .left
            
            
        }
        else
        {
            // fa // ar
            newsTitleLbl.textAlignment = .right
        }
        
    }
    @objc func  goToSection(_ sender: UIGestureRecognizer)  {
        if(artice == nil || artice!.sectionId == nil ){
            return
            
        }
        
        let taxonomy = Taxonomy()
        taxonomy.type = .SECTION
        taxonomy.name = artice!.sectionName
        taxonomy.id = artice?.sectionId!
        FromTypeSection = false
        AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: RootViewController.shared!  )
        
    }

    
    func configureWithData(_ article: Article)
    {   self.artice = article
        newsTitleLbl.text = article.title
        newsTypeLbl.text = article.sectionName
         let realm = try! Realm()
        let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: article.sectionId)?.color
       // newsTypeLbl.textColor = articelColor?.hexStringToUIColor()
        colorView.backgroundColor = articelColor?.hexStringToUIColor()
        Sectionlbl.text = article.sectionName
        PageImage.kf.setImage(with: URL(string:(article.mainImg)!),options: [.transition(.fade(0.2))])
        let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
        newsTimelbl.text = date.timeAgoSinceNow
        
    }
    
    func layoutView() {
        
        // set the shadow of the view's layer
//        layer.backgroundColor = UIColor.clear.cgColor
//        conteainerImage.layer.shadowColor = UIColor.black.cgColor
//        conteainerImage.layer.shadowOffset = CGSize(width: 1, height: 1.0)
//        conteainerImage.layer.shadowOpacity = 0.8
//        conteainerImage.layer.shadowRadius = 10.0
//        conteainerImage.clipsToBounds = false
//
//        conteainerImage.layer.masksToBounds = false
//        conteainerImage.layer.shadowColor = UIColor.darkGray.cgColor
//        conteainerImage.layer.shadowOpacity = 0.3
//        conteainerImage.layer.shadowOffset = CGSize.zero
//        conteainerImage.layer.shadowRadius = 2.5

        
        
        // set the cornerRadius of the containerView's layer
       // PageImage.layer.cornerRadius = 5
        PageImage.layer.masksToBounds = true
        PageImage.clipsToBounds = true
//        addSubview(conteainerImage)
        
        //
        // add additional views to the containerView here
        //
        
        // add constraints
     //   conteainerImage.translatesAutoresizingMaskIntoConstraints = false
//
//        // pin the containerView to the edges to the view
//        conteainerImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        conteainerImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        conteainerImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        conteainerImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
