//
//  AppDelegate + NotificationCenter.swift
//  Al-Ain
//
//  Created by imac on 10/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UserNotifications

//extension AppDelegate : UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//        completionHandler([])
//        showNoification(userInfo)
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        
//        print(userInfo)
//        
//        completionHandler()
//        
//        
//        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
//            if let articleId = (userInfo as NSDictionary).value(forKey:articleIdKey) as! String! {
//                openArticle(articleId)
//                
//            }
//        }
//        
//    }
//
//    func openArticle(_ articleId:String)    {
//
//        if RootViewController.shared == nil {
//            RootViewController.displayArticleWithId = articleId
//        } else {
//            AppUtils.launchSingleArticleView(articleId: articleId, controller: RootViewController.shared!)
//        }
//    }
//}



