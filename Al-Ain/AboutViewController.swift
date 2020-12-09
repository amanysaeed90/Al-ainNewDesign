//
//  AboutViewController.swift
//  Al-Ain
//
//  Created by imac on 9/4/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import PureLayout



class AboutViewController: UIViewController {
    
    
    var navigatToURL:URLRequest! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        

        title =  "About".localized()
        let webView = WKWebView();
        self.view.addSubview(webView)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        var constraint = webView.autoPinEdge(.top, to: .top, of: view)
        constraint.constant = 0
        constraint =    webView.autoPinEdge(.trailing, to: .trailing, of: view)
        constraint.constant = 0
        
        constraint = webView.autoPinEdge(.leading, to: .leading, of: view)
        constraint.constant = 0
        
        constraint =  webView.autoPinEdge(.bottom, to: .bottom, of: view)
        constraint.constant = 0
        
        
        
        if navigatToURL == nil {
            if let path = Bundle.main.path(forResource: "about", ofType: "html") {
                webView.load(URLRequest(url : URL(fileURLWithPath: path)))
            }
        }else {
            webView.load( navigatToURL)
            
        }
        webView.navigationDelegate = self
    }
    
    
    
    
}


extension AboutViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeSpinner()
       // AppUtils.removeWait(self.view)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
       // AppUtils.showWait(self.view)
        self.showSpinner(onView: self.view)

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

        
}

