//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Veronika Hristozova on 4/19/17.
//  Copyright © 2017 Centroida. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CoreMotion


class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationBody: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        accelometerUpdate()
        
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: size.height / 2)
    }
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        
        if let urlImageString = content.userInfo["img"] as? String {
            if let url = URL(string: urlImageString) {
                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                    if let _ = error {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        if let title = content.userInfo["title"] as? String {
            self.notificationTitle.text = title
            }
        if let body = content.userInfo["body"] as? String {
            self.notificationBody.text = body
        }
        
    }
    
}

extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
