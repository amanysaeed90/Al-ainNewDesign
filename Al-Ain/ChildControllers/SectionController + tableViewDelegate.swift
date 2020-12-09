//
//  SectionController + tableViewDelegate.swift
//  Al-Ain
//
//  Created by imac on 9/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import  UIKit


extension SectionController : UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tib?.dismiss()
        if(articles[indexPath.row].nodeType == Article.BANNER_ARTICLE_TYPE ){
            
            let about = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            about.navigatToURL   =  URLRequest(url: URL(string: articles[indexPath.row].fullurl!)!)
            self.navigationController?.pushViewController(about, animated: true)
            
            return
        }
        var  title = ""
        if taxonomy.name != nil {
            title = taxonomy.name!
        }
        
        AppUtils.launchArticlesPagerController(articles: self.articles, index : indexPath.row, controller: self ,title:title)
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scriolling .. ")
        //        self.tableView.hideAllToasts()
        //        self.tableView.clearToastQueue()
        
    }
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scriolling .. ")
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    
    
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //your code
        if Reachability.isConnectedToNetwork() == true {
            
            
            if (self.lastContentOffset < scrollView.contentOffset.y) {
                print("up")
                print(scrollView.contentOffset.y)
                if (scrollView.contentOffset.y > 150)
                {
                    
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                        self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                        
                        if #available(iOS 13.0, *) {
                            self.setnavigationWhite_tintGray()}
                        self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite_gray"), for: .normal)
                        
                    }, completion: {(finished:Bool) in
                        //
                    })
                    
                    
                }
                if (scrollView.contentOffset.y < 150)
                {
                    UIView.animate(withDuration: 0.3) {
                        
                        //                                if #available(iOS 13.0, *) {
                        //                                                                                let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                        //                                                                                                                                                       if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                        //                                                                                                                                                       statusBar.backgroundColor = UIColor.clear
                        //                                                                                                                                                       }
                        //
                        //                                                                                          } else {
                        //                                                                                                let statusBar = UIApplication.shared.value(forKeyPath:
                        //                                                                                             "statusBarWindow.statusBar") as? UIView
                        //                                                                                                 statusBar?.backgroundColor = UIColor.clear
                        //                                                                                          }
                        if #available(iOS 13.0, *) { self.setnavigationClear_tintWhite()}
                        self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                        self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
                        
                        
                        
                    }
                    
                }
                // did move up
            } else if (self.lastContentOffset > scrollView.contentOffset.y) {
                // did move down
                print("down")
                if (scrollView.contentOffset.y < 150 && scrollView.contentOffset.y > 0)
                {
                    UIView.animate(withDuration: 0.3) {
                        if #available(iOS 13.0, *) {
                            self.setnavigationClear_tintWhite()
                        }
                        
                        self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                        self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
                        
                        
                    }
                    
                }
                
                
                //            else if (scrollView.contentOffset.y < 0)
                //            {
                //                if #available(iOS 13.0, *) {
                //                                  self.setnavigationClear_tintWhite()
                //                                  }
                //
                //            }
                
                print(scrollView.contentOffset.y)
                
            } else {
                // didn't move
            }
        }
        else
        {
            if (articles.count == 0){
                if #available(iOS 13.0, *) {
                    self.setnavigationWhite_tintGray()
                }
                self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite_gray"), for: .normal)
                self.removeSpinner()
                
                self.NetEror.isHidden = false
            }
            else
            {
                if (self.lastContentOffset < scrollView.contentOffset.y) {
                    print("up")
                    print(scrollView.contentOffset.y)
                    if (scrollView.contentOffset.y > 160)
                    {
                        
                        
                        
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                            self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                            
                            if #available(iOS 13.0, *) {
                                self.setnavigationWhite_tintGray()}
                            self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite_gray"), for: .normal)
                            
                        }, completion: {(finished:Bool) in
                            //
                        })
                        
                        
                    }
                    if (scrollView.contentOffset.y < 130)
                    {
                        UIView.animate(withDuration: 0.3) {
                            
                            //                                if #available(iOS 13.0, *) {
                            //                                                                                let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                            //                                                                                                                                                       if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                            //                                                                                                                                                       statusBar.backgroundColor = UIColor.clear
                            //                                                                                                                                                       }
                            //
                            //                                                                                          } else {
                            //                                                                                                let statusBar = UIApplication.shared.value(forKeyPath:
                            //                                                                                             "statusBarWindow.statusBar") as? UIView
                            //                                                                                                 statusBar?.backgroundColor = UIColor.clear
                            //                                                                                          }
                            if #available(iOS 13.0, *) { self.setnavigationClear_tintWhite()}
                            self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                            self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
                            
                            
                            
                        }
                        
                    }
                    // did move up
                } else if (self.lastContentOffset > scrollView.contentOffset.y) {
                    // did move down
                    print("down")
                    if (scrollView.contentOffset.y < 171 && scrollView.contentOffset.y > 0)
                    {
                        UIView.animate(withDuration: 0.3) {
                            if #available(iOS 13.0, *) {
                                self.setnavigationClear_tintWhite()
                            }
                            
                            self.navigationController?.navigationBar.topItem?.title = self.taxonomy.name
                            self.addToMyNews?.setImage(UIImage(named: "star-shape-favorite-White"), for: .normal)
                            
                            
                        }
                        
                    }
                    //            else if (scrollView.contentOffset.y < 0)
                    //            {
                    //                if #available(iOS 13.0, *) {
                    //                                  self.setnavigationClear_tintWhite()
                    //                                  }
                    //
                    //            }
                    print(scrollView.contentOffset.y)
                    
                } else {
                    // didn't move
                }
            }
        }
        
        
        
    }
}
extension UIApplication {
    
    class var statusBarBackgroundColor: UIColor? {
        get {
            return statusBarUIView?.backgroundColor
        } set {
            statusBarUIView?.backgroundColor = newValue
        }
    }
    
    class var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 987654321
            
            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                return statusBar
            }
            else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                UIApplication.shared.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }}
extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            
            if responds(to: #selector(getter: UIWindowScene.statusBarManager)) {
                return value(forKey: "statusBar") as? UIView
                print("Done")
            }
            print("ff")
        } else {
            // Fallback on earlier versions
            print("MM")
        }
        return nil
    }
}
