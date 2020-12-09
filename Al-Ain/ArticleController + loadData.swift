//
//  ArticleController + loadData.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//
import Foundation
import WebKit
import UIKit
import SKPhotoBrowser
import FittedSheets
import RealmSwift

extension ArticleController {
     func getArticleTaxonomies(){
        var  tax = Taxonomy()
        if article.sectionId    != nil {
            tax.id =   article.sectionId!
            tax.name = article.sectionName
            tax.type = .SECTION
            tax.taxType = "category"
            taxonomies.append(tax)
        }
        if article.pageId != nil {
            tax = Taxonomy()
            tax.id = article.pageId!
            tax.name = article.pageName
            tax.taxType = "page"

            tax.type = .PAGE
            taxonomies.append(tax)

        }
        
        if(article.countries != nil){
            for tax in article.countries {
                var taxs = Taxonomy()
                taxs.id = tax.id
                taxs.name = tax.name
                
                taxs.type = .COUNTRY
                taxs.taxType = "countries"

                     taxonomies.append(taxs)
               
                

               
            }
        }
        if(article.tags != nil){
            for tax in article.tags {
//                tax.type = .TAG
                var taxs = Taxonomy()
                taxs.id = tax.id
                taxs.name = tax.name
                taxs.taxType = "tags"
                taxs.type = .TAG
                taxonomies.append(taxs)
            }
        }
//        do {
//                       let realm = try Realm()
//                       try realm.write {
//                            realm.add(taxonomies,update: true)
//                       }
//                       }
//                       catch let error as NSError {
//                       }
     }
}

extension ArticleController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppUtils.removeWait(self.view)
        if( webViewHeight != 0 ){
            return
        }
        loadArticleDetails()//(document.height !== undefined) ? document.height : document.body.offsetHeight;
        
        
        
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
           if complete != nil {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let height = webView.scrollView.contentSize.height
             print("height of webView is: \(height)")
//            document.querySelector(img).classList.contains('lazyloaded');
            webView.evaluateJavaScript("(document.height !== undefined) && (document.querySelector(img).classList.contains('lazyloaded')) ? document.body.offsetHeight : document.body.offsetHeight;") { (result, error) in
               // if let constraint = (webView.constraints.filter{$0.secondAttribute == .height}.last) {
                   // print(constraint)
                print(result)
                self.webViewHeight = webView.scrollView.contentSize.height//result as! CGFloat//webView.scrollView.contentSize.height//CGFloat(result as! Float)
                    print(self.webViewHeight)
               // }
                DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .none)
                }
                
                self.removeSpinner()
                 }
            }
           }
         })
        
        
     
        
    }
   
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated  {
            decisionHandler(.cancel)
            
            let about = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            about.navigatToURL   =  navigationAction.request
            let sheetController = SheetViewController(controller: about)
            sheetController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.present(sheetController, animated: true, completion: nil)
            //self.navigationController?.pushViewController(about, animated: true)
            
            
        } else {
            let urlString = navigationAction.request.url?.absoluteString
            
            if (urlString?.hasSuffix("_img"))!{
                
                let end = urlString?.index((urlString?.endIndex)!, offsetBy: -4)
                
                self.showZoomableImage( (urlString?.substring(to: end!))!)
                decisionHandler(.cancel)
                return
            }
            
            
            decisionHandler(.allow)
        }
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
        present(browser, animated: true, completion: {})
        
    }
    
    
    func configureWebView(_ webView:WKWebView) {
        if (webView.tag != 123)
        {
            webView.invalidateIntrinsicContentSize()
            return
        }
        webView.tag = 0
      //  AppUtils.showWait(view)
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false//img{width:100% !important;height:auto !important;}
        
        
        var html: String = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, minimal-ui' /><link rel=\"stylesheet\" href=\"iPhone.css\"><script src='lazy_load.js'></script><style>@font-face{font-family: 'HelveticaNeueLTArabic-Bold'; src: local('HelveticaNeueLTArabic-Roman'),url('helveticaneuelt-arabic-55-roman.ttf') format('opentype');}body {font-family: 'HelveticaNeueLTArabic-Bold';font-size:70%;text-align: left; text-justify: none;}p{color:#5B5B5B;line-height:1 !important;}</style></head><body dir='rtl' style='font-family:HelveticaNeueLTArabic-Bold;font-size:16;'>"

       /* if self.article.details != nil && !self.article.convertedDtailsFromBase64 {
            do {
                let realm = try Realm()
                try realm.write {
                    self.article.details = AppUtils.getStringFromBase64(input:self.article.details! )
                    //self.article.details = self.article.details?.replacingOccurrences(of: "src=", with: "data-src=")
                    self.article.convertedDtailsFromBase64 = true
                }
            }
            catch let error as NSError {
                print(error)
                self.article.details = AppUtils.getStringFromBase64(input:self.article.details! )
                //self.article.details = self.article.details?.replacingOccurrences(of: "src=", with: "data-src=")
                self.article.convertedDtailsFromBase64 = true
            }
           
        }*/
        var art = self.article
        do {
            let realm = try Realm()

        try! realm.write {
            if self.article.details != nil && !self.article.convertedDtailsFromBase64 {
                print(self.article.details)
                print(AppUtils.getStringFromBase64(input:(art?.details)! ))
                art?.details = AppUtils.getStringFromBase64(input:(art?.details)! )
                art?.details = art?.details!.replacingOccurrences(of: "src=", with: "data-src=")
                art?.convertedDtailsFromBase64 = true
            }        }
     
        }
        catch let error as NSError {
        }
        
        
        if let details = self.article.details {
            
        print(self.article.details!)
        html.append(details)
        }
        html.append("<br></body></html>")
        let videoID = "oOBLIKC0SYI" // https://www.youtube.com/watch?v=zN-GGeNPQEg

        // Set up your HTML.  The key URL parameters here are playsinline=1 and autoplay=1
        // Replace the height and width of the player here to match your UIWebView's  frame rect
        // let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.view.frame.size.width)' height='\(self.view.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"

        webView.loadHTMLString(html, baseURL: URL(fileURLWithPath:Bundle.main.path(forResource:"iPhone" , ofType:"css" )!))
    }
    
}

extension ArticleController{
    func loadArticleDetails(){
        if self.relatedArticles.count > 0{

            return
        }
        
        let  id = articleId == nil ? self.article.id! : articleId
        if  articleId != nil {        AppUtils.showWait(self.view)        }
        APIManager.getArticleDetails(id:  id!,  suceess: { (article:Article) in
            if self.article == nil {
                 self.article = article
                let array = Array(article.related)
                self.relatedArticles = array
                self.loadData()
                if(self.articleId != nil){
                    self.tableView.reloadData()}
                AppUtils.removeWait(self.view)
            }else {
                self.relatedArticles.append(contentsOf: article.related )
                self.tableView.reloadSections([1], with: .bottom)
                
            }
        }) { (error:Error?) in
            if self.article == nil{
                self.showErrorView()
            }
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
    
    
    func showErrorView(){
        AppUtils.showErrorView(self,retryHandler: #selector(retry));
    }
    
    
    @objc func retry (_ sender: UIGestureRecognizer){
        AppUtils.showWait(self.view)
        
        self.loadArticleDetails()
        
    }
    
}



