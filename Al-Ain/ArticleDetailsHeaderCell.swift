//
//  ArticleDetailsHeaderCell.swift
//  Al-Ain
//
//  Created by imac on 8/31/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Localize_Swift
import UIKit
import Kingfisher
import FontAwesome_swift
import AVKit
import AVFoundation
import FacebookShare
import YouTubePlayer
import AVKit
import AVFoundation
import SKPhotoBrowser
import WebKit

class ArticleDetailsHeaderCell: UITableViewHeaderFooterView,WKUIDelegate{
    
    @IBOutlet weak var ArticleImg: UIImageView!
    @IBOutlet weak var nuOfViews: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var page: UILabel!
    @IBOutlet weak var autherName: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var audio: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var whatsapp: UIButton!
    @IBOutlet weak var facebook: UIButton!
    
    @IBOutlet weak var ImgTitle: UILabel!
    
    @IBOutlet weak var videoPlayer2: YouTubePlayerView!
    @IBOutlet weak var photoContainer: UIView!
    var article:Article!
    var vc : ArticleController!
    
    var videoEmbeded: WKWebView!
    @IBOutlet weak var EmbedeViewContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.EmbedeViewContainer.frame.size.height))
        self.videoEmbeded = WKWebView (frame: customFrame , configuration: webConfiguration)
        videoEmbeded.translatesAutoresizingMaskIntoConstraints = false
        self.EmbedeViewContainer.addSubview(videoEmbeded)
        videoEmbeded.topAnchor.constraint(equalTo: EmbedeViewContainer.topAnchor).isActive = true
        videoEmbeded.rightAnchor.constraint(equalTo: EmbedeViewContainer.rightAnchor).isActive = true
        videoEmbeded.leftAnchor.constraint(equalTo: EmbedeViewContainer.leftAnchor).isActive = true
        videoEmbeded.bottomAnchor.constraint(equalTo: EmbedeViewContainer.bottomAnchor).isActive = true
        videoEmbeded.heightAnchor.constraint(equalTo: EmbedeViewContainer.heightAnchor).isActive = true
        videoEmbeded.uiDelegate = self
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
       // videoEmbeded.load(myRequest)
        videoPlayer2.layer.cornerRadius = 10
        videoPlayer2.isHidden = true
        sectionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
        page.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSection)))
        
        
        let buttonFont = UIFont.fontAwesome(ofSize: 25)
        
        facebook!.titleLabel?.font = buttonFont
        facebook!.setTitle(String.fontAwesomeIcon(name: .facebook), for: .normal)
        facebook!.layer.cornerRadius = 5.0
        facebook!.layer.masksToBounds = true
        
        
        twitter!.titleLabel?.font = buttonFont
        twitter!.setTitle(String.fontAwesomeIcon(name: .twitter), for: .normal)
        twitter!.layer.cornerRadius = 5.0
        twitter!.layer.masksToBounds = true
        
        whatsapp!.titleLabel?.font = buttonFont
        whatsapp!.setTitle(String.fontAwesomeIcon(name: .whatsapp), for: .normal)
        whatsapp!.layer.cornerRadius = 5.0
        whatsapp!.layer.masksToBounds = true
        
        audio!.titleLabel?.font = buttonFont
        audio!.setTitle(String.fontAwesomeIcon(name: .headphones), for: .normal)
        audio!.layer.cornerRadius = 5.0
        audio!.layer.masksToBounds = true
        
        
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            self.title.textAlignment = .left
            self.desc.textAlignment = .left
            
        }
        else
        {
            // fa // ar
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        
        
        
    }
    func getVideoId(text : String) ->String{
        if text.isEmpty {
            return ""
        }
        
        let pattern: String = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        var excepression: NSRegularExpression
        do {
            excepression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch let error as NSError {
            print(error.localizedDescription)
            return ""
        }
        let range = NSMakeRange(0, text.characters.count)
        let match: NSTextCheckingResult = excepression.firstMatch(in: text, options: [], range: range)!
        return  (text as NSString).substring(with: match.range)
        
    }
    func   showZoomableImage(_ current:String){
        var images = [SKPhoto]()
        let imageUrls:[String] = AppUtils.extractImgUrlsFromString(input: (article.details)!)
        var photo = SKPhoto.photoWithImageURL(imageUrl)
        photo.shouldCachePhotoURLImage = true
        images.append(photo)
        var selectedIndex = 0
        for (index,url) in imageUrls.enumerated() {
            photo = SKPhoto.photoWithImageURL(url)
            photo.shouldCachePhotoURLImage = true
            images.append(photo)
            
            if url == current {
                selectedIndex = index + 1
            }
        }
        let browser = SKPhotoBrowser(photos: images)
        browser.showToolbar(bool: true)
        browser.initializePageIndex(selectedIndex)
        SKPhotoBrowserOptions.displayAction = false
        vc?.present(browser, animated: true, completion: {})
        
    }
    
    
    @objc func openZoomedImage(_ sender:UIGestureRecognizer){
        showZoomableImage(imageUrl)
    }
    var imageUrl = "";
    
    func configureWithData(_ article: Article , vc:ArticleController) {
        self.vc = vc
        self.article = article
        
        
          if (article.videoCode == nil ){
            videoPlayer2.isHidden = true
            photo.superview?.isHidden = false
            EmbedeViewContainer.isHidden = true
            if let imagefounded = article.mainImg , let imagefoundedthum = article.thumbImg {
                imageUrl =  article.mainImg == nil ? imagefoundedthum : imagefounded
            }
            photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openZoomedImage)))
            photo.kf.setImage(with: URL(string:(imageUrl)),options: [.transition(.fade(0.2))])
            ImgTitle.text = article.titleImg
            if (article.nodeType == Article.OPINION_ARTICLE_TYPE)
            {
//                photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToAutherArticles)))
                photo.isUserInteractionEnabled = true
            }
            
            
        }else {
            
         
            if((article.videoCode?.contains("youtube")) == true){
                photo.superview?.isHidden = true
                         videoPlayer2.isHidden = false
                EmbedeViewContainer.isHidden = true

                self.videoPlayer2.loadVideoID(self.getVideoId(text:self.article.videoCode!))
            }else
            {
                photo.superview?.isHidden = true
                    videoPlayer2.isHidden = true
                EmbedeViewContainer.isHidden = false
                var html: String = "<html><body>"
                
                
                html.append(article.videoCode ?? "")
                
                
                html.append("</body></html>")
                videoEmbeded.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
                
            }
            
        }

        
        
        /*if (article.videoCode == nil ){
            videoPlayer2.isHidden = true
            if let imagefounded = article.mainImg , let imagefoundedthum = article.thumbImg {
                imageUrl =  article.mainImg == nil ? imagefoundedthum : imagefounded
            }
            photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openZoomedImage)))
            photo.kf.setImage(with: URL(string:(imageUrl)),options: [.transition(.fade(0.0))])
            
        }else {
            photoContainer.isHidden = true
            videoPlayer2.isHidden = false
            self.videoPlayer2.loadVideoID(self.getVideoId(text:self.article.videoCode!))
            
        }
        */
        
        
        audio.isHidden =     (article.audioUrl == nil)
        
        
        nuOfViews.text = "\(article.Hits) مشاهدة"
        title.text = article.title
       self.ImgTitle.text = article.titleImg//?.html2String
        var descs = article.descriptionValue?.replacingOccurrences(of: "\n", with: "")
        descs = descs?.replacingOccurrences(of: "\r", with: "")
        desc.text = descs
        sectionTitle.text = article.sectionName
        let date = Date(timeIntervalSince1970: TimeInterval(article.updated))
        
        time.text = date.timeAgoSinceNow
        
        if article.autherName != nil  {
            autherName.text = article.autherName
        }
        
        if article.pageName != nil  {
            page.text = article.autherName
            
        }
        ArticleImg.kf.setImage(with: URL(string:article.thumbImg!),options: [.transition(.fade(0.0))])
        
        
    }
    
    @objc func  goToSection(_ sender: UIGestureRecognizer)  {
        if(article == nil){
            return }
        
        let taxonomy = Taxonomy()
        
        if sender.view == page {
            taxonomy.type = .PAGE
            taxonomy.name = article.pageName
            taxonomy.id = article.pageId!
            
        }else{
            taxonomy.type = .SECTION
            taxonomy.name = article.sectionName
            taxonomy.id = article.sectionId!
            
        }
        SectionFromMenu = false
        FromTypeSection = false
        
        AppUtils.launchSectionViewController( taxonomy:taxonomy , controller: RootViewController.shared!  )
    }
    
    
    
    
    @IBAction func shareFacebook(_ sender: Any) {
        let content = LinkShareContent(url: URL(string:article.fullurl!)!)
        do{
            try ShareDialog.show(from: RootViewController.shared!, content: content)
        }catch{
            
        }
    }
    
    @IBAction func shareWhatsapp(_ sender: Any) {
        let msg = article.title! + " " + article.fullurl!
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL,options: [:], completionHandler: nil)
                } else {
                    let banner = Banner(title: "",subtitle:"قم بتثبيت تطبيق الواتساب اولا" ,  backgroundColor: UIColor.black)
                    banner.dismissesOnTap = true
                    banner.show(duration: 1.0)
                    
                }
            }
        }
    }
    @IBAction func shareTwitter(_ sender: Any) {
        let tweetUrl = article.fullurl!
        let shareString = "https://twitter.com/intent/tweet?url=\(tweetUrl)&text=\(article.title!)"
        
        // encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        // cast to an url
        let url = URL(string: escapedShareString)
        
        // open in safari
        UIApplication.shared.open(url!,options: [:], completionHandler: nil)
        
        
    }
    @IBAction func playAudio(_ sender: Any) {
        
        vc!.setupAudioPlayer()
        vc!.showAudioPlayer()
    }
    
    
    
}

