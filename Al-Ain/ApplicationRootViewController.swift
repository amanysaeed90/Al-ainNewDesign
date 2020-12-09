//
//  ApplicationRootViewController.swift
//  DrawerMenu
//

import UIKit
import DrawerMenu
import Localize_Swift
class ApplicationRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let center = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        let right = UIStoryboard(name: "Left", bundle: nil).instantiateInitialViewController()!
        
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{

            let drawer = DrawerMenu(center: center, left: right, right: nil)
            addChildViewController(drawer)
            view.addSubview(drawer.view)
            drawer.didMove(toParentViewController: self)        }
        else
        {
            // fa // ar
            let drawer = DrawerMenu(center: center, left: nil, right: right)
            addChildViewController(drawer)
            view.addSubview(drawer.view)
            drawer.didMove(toParentViewController: self)
            
        }
        
        
       
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
       // self.setupNavigationBar()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawer()?.panGestureType = .pan
    }
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
          if #available(iOS 13.0, *) {
              return .darkContent
          } else {
              // Fallback on earlier versions
              return .default
          }
      }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        drawer()?.panGestureType = .none

    }

}
