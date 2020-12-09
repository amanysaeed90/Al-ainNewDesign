//
//  WebViewCell.swift
//  Al-Ain
//
//  Created by imac on 8/31/17.
//  Copyright © 2017 egygames. All rights reserved.
//


import Foundation
import UIKit
import WebKit
import PureLayout
class WebViewCell : UITableViewCell,UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate {
    let webView: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.isOpaque = false
        wv.backgroundColor = .clear
        wv.scrollView.backgroundColor = .clear
        wv.scrollView.isScrollEnabled = false
        wv.scrollView.bounces = false
        wv.alpha = 1.0
        
        return wv
    }()
    
    override func awakeFromNib() {
  
       
        self.contentView.addSubview(webView)
        webView.tag = 123
        
        var constraint = webView.autoPinEdge(.top, to: .top, of: contentView)
        constraint.constant = 5
        constraint =    webView.autoPinEdge(.trailing, to: .trailing, of: contentView)
        constraint.constant = -5
        
        constraint = webView.autoPinEdge(.leading, to: .leading, of: contentView)
        constraint.constant = 5
        
        constraint =  webView.autoPinEdge(.bottom, to: .bottom, of: contentView)
        constraint.constant = -5
        
         
    }
    
//    func performAnimation() {
//   
//        webView.navigationDelegate = self
//        webView.uiDelegate=self
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//      
//   print("finishr")
//        }
//   
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//    print("loading...")
//    }
//    
//    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//        print("cool...")
//    }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        switch navigationAction.navigationType {
//        case .linkActivated:
//            if navigationAction.targetFrame == nil {
//                self.webView.load(navigationAction.request)// It will load that link in same WKWebView
//            }
//        default:
//            break
//        }
//        
//        if let url = navigationAction.request.url {
//            print(url.absoluteString) // It will give the selected link URL
//            
//        }
//        decisionHandler(.allow)
//    }
//    
////    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
////        if navigationAction.navigationType == WKNavigationType.linkActivated {
////            print("link")
////
////            decisionHandler(WKNavigationActionPolicy.cancel)
////            return
////        }
////        print("no link")
////        decisionHandler(WKNavigationActionPolicy.allow)
////    }
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if navigationAction.targetFrame == nil {
//            webView.load(navigationAction.request)
//        }
//        return nil
//    }
   
    
}


// this handles target=_blank links by opening them in the same view
