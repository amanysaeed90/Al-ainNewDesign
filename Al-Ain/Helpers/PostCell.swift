

import UIKit
import Kingfisher
import FontAwesome_swift
import ObjectMapper
import AlgoliaSearch
import RealmSwift
import Localize_Swift
import SkeletonView

class PostCell: UITableViewCell {
    
    static let featuredCellIdentifier = "FeaturedPostCell"
    var parentViewController:UIViewController?
    
    @IBOutlet weak var ShareBtn: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var autherName: UILabel!
    @IBOutlet weak var SeparatorLine: UIView!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorviewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var SectionTraling: NSLayoutConstraint!
    @IBOutlet weak var timeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var SectionwidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var photowidthRatio: NSLayoutConstraint!
    var artice:Article?
    var ArticleID:String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     SeparatorLine?.showAnimatedGradientSkeleton()
        sectionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
        sectionTitle.isUserInteractionEnabled = true
        if autherName != nil{
        autherName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToAutherArticles)))
        autherName.isUserInteractionEnabled = true
        }
        print("PhoneScreen")
        print(UIDevice.current.screenType)
        //photowidthRatio = photowidthRatio.setMultiplier(newMultiplier)
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            title.textAlignment = .left
            sectionTitle.textAlignment = .left
            time.textAlignment = .left
            autherName?.textAlignment = .left
            
        }
        else
        {
            // fa // ar
            title.textAlignment = .right
            sectionTitle.textAlignment = .right
            time.textAlignment = .right
            autherName?.textAlignment = .right

            
        }
        
        
       
        
    }
    func hideanimation(){
        title?.hideSkeleton()
        photo?.hideSkeleton()
        ShareBtn?.hideSkeleton()
        sectionTitle?.hideSkeleton()
        time?.hideSkeleton()
        autherName?.hideSkeleton()
        SeparatorLine?.hideSkeleton()
        SaveBtn?.hideSkeleton()
    }
    @IBAction func shareAction(_ sender: UIButton) {
        
        if let title = artice?.title{
            let url: URL! = URL(string: artice!.fullurl!)
            let vc = UIActivityViewController(activityItems: [title, url], applicationActivities: [])
            
            
            let popover = vc.popoverPresentationController
            popover?.sourceView = parentViewController?.view
           // popover?.barButtonItem = parentViewController
            parentViewController?.present(vc, animated: true, completion: {
                UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.accentColor], for: .normal)
                
            })
      
        
        }
    }
    func objectExist (id: String) -> Bool {
                             
               let realm = try! Realm()
               return realm.object(ofType: SavedArticle.self, forPrimaryKey: id) != nil
       }
    
    @IBAction func SaveAction(_ sender: UIButton) {
        if let artfound = artice{
          
                    do{
                    let realm = try Realm()
                    sender.loadingIndicator(true)
                      try realm.write {

                        let SavedArt = SavedArticle(Art: artice!)
                        SavedArt?.SavedArticel = artice
                        SavedArt?.id = artice!.id!
                        print("///////////")
                        print(SavedArt)
                        if (self.objectExist(id: artice!.id!))
                        {
                            realm.delete(realm.objects(SavedArticle.self).filter("id=%@",artice!.id!))
                            
                                if (parentViewController is MediaTypesVC || parentViewController is PhotosVC ){
                                   self.SaveBtn.setImage(UIImage(named: "Path 146"), for: .normal)
                                }
                                else{
                                self.SaveBtn.setImage(UIImage(named: "UnSave_Post"), for: .normal)}

                            
                            let title = sender.title(for: UIControlState())
                            self.indexPath.flatMap { print($0) }
                            let SelectData:[String: IndexPath] = ["IndethOfDeleted": self.indexPath!]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectDataToDeletSavePost"), object: nil, userInfo: SelectData)
                            sender.loadingIndicator(false)

                        }
                        else {
                            realm.add(SavedArt!, update: true)
                            self.SaveBtn.setImage(UIImage(named: "SavedPost"), for: .normal)
                            sender.loadingIndicator(false)
                        }
                        }
                      }
                      catch let error as NSError {
                        print(error)
                        sender.loadingIndicator(false)
                      }
        }
        else
        {
            if let ArtId = ArticleID
            {
                
                sender.loadingIndicator(true)
                APIManager.getArticleDetails(id:  ArtId,  suceess: { (article:Article) in
                           if article != nil {
                              
                            do{
                                              let realm = try Realm()
                                                try realm.write {
                                                  let SavedArt = SavedArticle(Art: article)
                                                  SavedArt?.SavedArticel = article
                                                  SavedArt?.id = article.id!
                                                  print("///////////")
                                                  print(SavedArt)
                                              
                                                      realm.delete(realm.objects(SavedArticle.self).filter("id=%@",article.id!))
                                                      
                                                      if (article.nodeType == Article.VIDEO_ARTICLE_TYPE ){
                                                        if (self.parentViewController is MediaTypesVC || self.parentViewController is PhotosVC ){
                                                                                                                          self.SaveBtn.setImage(UIImage(named: "Path 146"), for: .normal)
                                                                                                                       }
                                                                                                                       else{
                                                                                                                       self.SaveBtn.setImage(UIImage(named: "UnSave_Post"), for: .normal)}
                                                                          
                                                    let title = sender.title(for: UIControlState())
                                                      self.indexPath.flatMap { print($0) }
                                                      let SelectData:[String: IndexPath] = ["IndethOfDeleted": self.indexPath!]
                                                      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectDataToDeletSavePost"), object: nil, userInfo: SelectData)
                                                      sender.loadingIndicator(false)

                                                  }
                                                  else {
                                                      realm.add(SavedArt!, update: true)
                                                      self.SaveBtn.setImage(UIImage(named: "SavedPost"), for: .normal)
                                                    sender.loadingIndicator(false)
                                                  }
                                                  }
                                                }
                                                catch let error as NSError {
                                                  print(error)
                                                    sender.loadingIndicator(false)
                                                }
                            
                            
                            
                           }else {
                             sender.loadingIndicator(false)
                            
                               
                           }
                       }){ (error:Error?) in
//                           if self.article == nil{
//                               self.showErrorView()
//                           }
                        sender.loadingIndicator(false)
                       }
                       
                
            }
            
        }
                        
        
    }
    
    func configureWithData(_ article: Article) {
       
        
        if(article.nodeType == Article.BANNER_ARTICLE_TYPE ){
            return
        }
       self.artice = article
       title.text = article.title
       title.textColor = .darkGray
     
       // title.attributedText = NSAttributedString(string: article.title ?? "", attributes: title.attributedText!.attributes(at: 0, effectiveRange: nil))

        sectionTitle.text =   "\(article.sectionName!)  "
        
        let realm = try! Realm()
        let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: article.sectionId)?.color
        if let color = colorView {
            color.backgroundColor = articelColor?.hexStringToUIColor()
        }
        
        
        if self.reuseIdentifier == PostCell.featuredCellIdentifier {
            photo.kf.setImage(with: URL(string:(article.mainImg)!),options: [.transition(.fade(0.0))])
        }else{
            photo.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.0))])
            
        }
      //  print(article.updated)
        
        let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
        
        time.text = date.timeAgoSinceNow
        
        if(article.nodeType == Article.OPINION_ARTICLE_TYPE  && autherName != nil){
            autherName.text = article.autherName
            
        }
        
        if(article.nodeType == Article.VIDEO_ARTICLE_TYPE  && playIcon != nil){
            playIcon.alpha = 1
        }
       
        if (self.objectExist(id: artice!.id!))
        {
            self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)
        }
        else {
     

        self.SaveBtn?.setImage(UIImage(named: "UnSave_Post"), for: .normal)}
        if (parentViewController is SectionController || parentViewController is HomePageViewController )
        {
            if let SectonTag = parentViewController as? SectionController {
                if (SectonTag.taxonomy.taxType == "tags")
                {
                    self.colorviewWidthConstraint?.constant = 3
                    self.SectionTraling?.constant = 23
                    
                }
                    
                else
                {
                    sectionTitle.text = ""
                    colorviewWidthConstraint?.constant = 0
                    timeLeadingConstraint?.constant = 0
                    SectionwidthConstraint?.constant = 0
                    SectionTraling?.constant = 15
                }
            }
            else
            {
            sectionTitle.text = ""
            colorviewWidthConstraint?.constant = 0
            timeLeadingConstraint?.constant = 0
            SectionwidthConstraint?.constant = 0
            SectionTraling?.constant = 15
            }
        }
        else
        {
            colorviewWidthConstraint?.constant = 3
            SectionTraling?.constant = 23
        }
       
    }
    func configureWithOpenion(_ article: Article) {
         
          
          if(article.nodeType == Article.BANNER_ARTICLE_TYPE ){
              return
          }
         self.artice = article
         title.text = article.title
         title.textColor = .darkGray
       
         // title.attributedText = NSAttributedString(string: article.title ?? "", attributes: title.attributedText!.attributes(at: 0, effectiveRange: nil))

          sectionTitle.text =   "\(article.sectionName!)  "
          
          let realm = try! Realm()
          let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: article.sectionId)?.color
          if let color = colorView {
              color.backgroundColor = articelColor?.hexStringToUIColor()
          }
          
          
          if self.reuseIdentifier == PostCell.featuredCellIdentifier {
              photo.kf.setImage(with: URL(string:(article.mainImg)!),options: [.transition(.fade(0.0))])
          }else{
              photo.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.0))])
              
          }
        //  print(article.updated)
          
          let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
          
          time.text = date.timeAgoSinceNow
          
          if(article.nodeType == Article.OPINION_ARTICLE_TYPE  && autherName != nil){
              autherName.text = article.autherName
              
          }
          
          if(article.nodeType == Article.VIDEO_ARTICLE_TYPE  && playIcon != nil){
            playIcon.alpha = 1
        }
        
          if (self.objectExist(id: artice!.id!))
          {
              self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)
          }
          else {
       

          self.SaveBtn?.setImage(UIImage(named: "UnSave_Post"), for: .normal)}
        
         
      }

       func configureWithDataPhoto(_ article: Article) {
           if(article.nodeType == Article.BANNER_ARTICLE_TYPE ){
               return
           }
          self.artice = article
          title.text = article.title
           sectionTitle.text =   "\(article.sectionName!)  "
           
           let realm = try! Realm()
           let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: article.sectionId)?.color
           if let color = colorView {
               color.backgroundColor = articelColor?.hexStringToUIColor()
           }
           
           
           if self.reuseIdentifier == PostCell.featuredCellIdentifier {
               photo.kf.setImage(with: URL(string:(article.mainImg)!),options: [.transition(.fade(0.0))])
           }else{
               photo.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.0))])
               
           }
         //  print(article.updated)
           
           let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
           
           time.text = date.timeAgoSinceNow
           
           if(article.nodeType == Article.OPINION_ARTICLE_TYPE  && autherName != nil){
               autherName.text = article.autherName
               
           }
           
           if(article.nodeType == Article.VIDEO_ARTICLE_TYPE  && playIcon != nil){
            playIcon.alpha = 1
        }
       
           if (self.objectExist(id: artice!.id!))
           {
               self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)
           }
           else {
               self.SaveBtn?.setImage(UIImage(named: "Path 146"), for: .normal)
        }
             
          
       }
       func configureWithData (_ json: JSONObject) {
      
        let hit:Hits = Mapper<Hits>().map(JSONObject: json)!
        if let hitcat = hit.category{
        sectionTitle.text = hitcat
        }
        title.text = hit.title//?.html2String
        // sectionTitle.isHidden = true
        
        let date = Date(timeIntervalSince1970: TimeInterval(hit.created))
        time.text = date.timeAgoSinceNow
        if hit.image != nil {
            photo.kf.setImage(with: URL(string: hit.image! ),options: [.transition(.fade(0.0))])
        }
        
            if (self.objectExist(id: json["objectID"] as! String))
               {
                   self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)
               }
               else {
                   self.SaveBtn?.setImage(UIImage(named: "UnSave_Post"), for: .normal)
               }
        
        APIManager.getArticleDetails(id:  hit.objectID!,  suceess: { (articleRe:Article) in
                                   if articleRe != nil {
                                      
                                    self.artice = articleRe
                                    let realm = try! Realm()
                                    let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: articleRe.sectionId)?.color
                                    if let color = self.colorView {
                                                          color.backgroundColor = articelColor?.hexStringToUIColor()
                                                      }
                                    if (self.objectExist(id: articleRe.id!))
                                                               {
                                                                   self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)

                                                               }
                                                               else {
                                                                   self.SaveBtn?.setImage(UIImage(named: "UnSave_Post"), for: .normal)
                                                               }
                                    
                                   }else {
                                     
                                       
                                   }
                               }){ (error:Error?) in
        //                           if self.article == nil{
        //                               self.showErrorView()
        //                           }
                               }
        
        
        //   time.isHidden = true
                   
//       
        
    }
    
    
    
    func configureWithData(_ related: Related) {
        title.text = related.title
        title.textColor = .darkGray
        self.time.text = ""
        photo?.kf.setImage(with: URL(string:related.img!),options: [.transition(.fade(0.0))])
      if (self.objectExist(id: related.id!))
               {
                   self.SaveBtn?.setImage(UIImage(named: "SavedPost"), for: .normal)
               }
               else {
                 self.SaveBtn?.setImage(UIImage(named: "UnSave_Post"), for: .normal)}
             

//        APIManager.getArticleDetails(id:  related.id!,  suceess: { (articleRe:Article) in
//            if articleRe != nil {
//            self.artice = articleRe
//                let date = Date(timeIntervalSince1970: TimeInterval(articleRe.updated))
//                self.time.text = date.timeAgoSinceNow
//                let realm = try! Realm()
//                     let articelColor = realm.object(ofType: Taxonomy.self, forPrimaryKey: articleRe.sectionId)?.color
//                if let color = self.colorView {
//                         color.backgroundColor = articelColor?.hexStringToUIColor()
//                     }
//                self.sectionTitle?.text = articleRe.sectionName
//
//        }}){ (error:Error?) in}
       
        
    }
    
    
    override func layoutSubviews() {
        if(autherName != nil){
//            photo.layer.cornerRadius = photo.bounds.height / 2
//            photo.layer.borderWidth = 1
//            photo.layer.borderColor = UIColor.gray.cgColor
//            photo.clipsToBounds = true
            
        }
    }
    
    
    @objc func goToAutherArticles(_ sender: UIGestureRecognizer)  {
        
        if(artice == nil || artice!.autherID == 0 )
        {   return
        }
        else
        {
            let taxonomy = Taxonomy()
            taxonomy.type = .OPONION
            taxonomy.name = artice!.autherName
            taxonomy.id = "\(artice!.autherID)"
            AppUtils.launchSectionViewControllerOpenion( taxonomy:taxonomy , controller: RootViewController.shared!  )
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

    
  
    
}
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
