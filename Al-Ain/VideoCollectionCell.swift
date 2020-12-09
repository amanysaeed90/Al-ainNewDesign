//
//  VideoCollectionCell.swift
//  Al-Ain
//
//  Created by imac on 9/27/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class VideoCollectionCell : UICollectionViewCell{
        @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    var interactonRemoved = false
    var artice:Article!
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = false
        sectionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
        sectionTitle.isUserInteractionEnabled = true
        
    }
    
    
    
    func configureWithData(_ article: Article) {
        if self.reuseIdentifier == PostCell.featuredCellIdentifier {
            photo.kf.setImage(with: URL(string:article.mainImg!),options: [.transition(.fade(0.2))])
        }else{
            photo.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.2))])
            
        }
        
        if(article.nodeType == Article.BANNER_ARTICLE_TYPE ){
            return
        }
        self.artice = article
       title.text = article.title
        sectionTitle.text = article.sectionName
        
        if self.reuseIdentifier == PostCell.featuredCellIdentifier {
            photo.kf.setImage(with: URL(string:article.mainImg!),options: [.transition(.fade(0.2))])
        }else{
            photo.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.2))])
            
        }
        let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
        
        time.text = date.timeAgoSinceNow
        
    
        
        if(article.nodeType == Article.VIDEO_ARTICLE_TYPE  && playIcon != nil){
            playIcon.image = UIImage.fontAwesomeIcon(name: .play, textColor: .white, size: CGSize(width: 25, height: 25))
            
        }
        
        
    }
    
    
    
    @objc func  goToSection(_ sender: UIGestureRecognizer)  {
        if(artice == nil || artice.sectionId == nil ){
            return
            
        }
        let taxonomy = Taxonomy()
        taxonomy.type = .SECTION
        taxonomy.name = artice.sectionName
        taxonomy.id = artice.sectionId!
        FromTypeSection = false
        AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: RootViewController.shared!  )
    }
    
    func objectExist (id: String) -> Bool {
                              
                let realm = try! Realm()
                return realm.object(ofType: SavedArticle.self, forPrimaryKey: id) != nil
        }
     
     @IBAction func SaveAction(_ sender: UIButton) {
                     do{
                     let realm = try Realm()
                       try realm.write {


                         let SavedArt = SavedArticle(Art: artice)
                         SavedArt?.SavedArticel = artice
                         SavedArt?.id = artice.id!
                         print("///////////")
                         print(SavedArt)
                         if (self.objectExist(id: artice.id!))
                         {
                             realm.delete(realm.objects(SavedArticle.self).filter("id=%@",artice.id!))
                             self.SaveBtn.setImage(UIImage(named: "UnSave_Post"), for: .normal)

                         }
                         else {
                             realm.add(SavedArt!, update: true)
                             self.SaveBtn.setImage(UIImage(named: "SavedPost"), for: .normal)
                         }
                         }
                       }
                       catch let error as NSError {
                         print(error)
                       }
         
     }
     

}
