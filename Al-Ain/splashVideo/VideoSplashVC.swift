//
//  VideoSplashVC.swift
//  Al-Ain
//
//  Created by amany elhadary on 7/10/19.
//  Copyright © 2019 egygames. All rights reserved.
//

import UIKit

class VideoSplashVC:VideoSplashViewController {
    override var prefersStatusBarHidden:Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "FR_Outro new", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            videoFrame = view.frame
            fillMode = .resizeAspectFill
            alwaysRepeat = true
            sound = true
            contentURL = url
            self.backgroundColor = #colorLiteral(red: 0.1324785352, green: 0.1329619884, blue: 0.2865845561, alpha: 1)
        }

    }
    func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = rootViewController
        }
    }
    override func playerItemDidReachEnd() {
        if (ApplicationOpen == 0)
        {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ApplicationRootViewController")
        //self.switchRootViewController(rootViewController: redViewController, animated: true) {
          //ApplicationRootViewController()
        self.switchRootViewController(rootViewController: redViewController, animated: true) {

        }
            ApplicationOpen = 1
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
