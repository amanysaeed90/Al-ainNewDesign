//
//  AppDelgate + receiveNotifications.swift
//  Al-Ain
//
//  Created by imac on 9/4/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SwiftOverlays
import UserNotifications
import RealmSwift

extension AppDelegate {
    
    func setupFirebase(_ application:UIApplication){
        
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        
        //        if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
        //            badgeCounter = counter
        //        }else{
        //            badgeCounter = 0
        //        }
        //        badgeCounter += 1
        //        UserDefaults.standard.set(badgeCounter, forKey: "badgeCounter")
        NotificationCenter.default.post(name: BadgeCounterNotificationName, object: nil)
        
        //showNoification(userInfo)
    }
    
    
    //    func updateBadge (){
    //        if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
    //            print(counter)
    //            badgeCounter = counter + 1
    //            print(badgeCounter)
    //            UserDefaults.standard.set(badgeCounter, forKey: "badgeCounter")
    //            UIApplication.shared.applicationIconBadgeNumber = badgeCounter
    //        }
    //    }
    //BackGround
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        
        let userInfo = userInfo as NSDictionary
        getNotificationData(userInfo:userInfo)
        
        NotificationCenter.default.post(name: BadgeCounterNotificationName, object: nil)
        // updateBadge ()
        //        if (application.applicationState == UIApplicationState.inactive || application.applicationState == UIApplicationState.background  ) {
        //            if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
        //                badgeCounter = counter
        //            }else{
        //                badgeCounter = 0
        //            }
        //            badgeCounter += 1
        //            UserDefaults.standard.set(badgeCounter, forKey: "badgeCounter")
        //            UIApplication.shared.applicationIconBadgeNumber = badgeCounter
        //        }else{
        //            NotificationCenter.default.post(name: BadgeCounterNotificationName, object: nil)
        //        }
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs token retrieved: \(token)")
        Messaging.messaging().subscribe(toTopic: topic)
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
    
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    //TODO:- handel badge
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        //        NotificationCenter.default.post(name: BadgeCounterNotificationName, object: nil)
        
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        //        var savedNotificationBody = ""
        //        var savedNotificationTitle = ""
        //        var savedNotificationImage = ""
        //        var savedNotificationArticleId = ""
        //        //1
        //        if let notificationArticleId = userInfo["article_id"] as? String{
        //            savedNotificationArticleId = notificationArticleId
        //        }
        //        //2
        //        if let notificationImage = userInfo["img"] as? String {
        //            savedNotificationImage = notificationImage
        //        }
        //
        //        if let aps = userInfo["aps"] as? NSDictionary {
        //            if let alert = aps["alert"] as? NSDictionary {
        //                //3
        //                if let notificationBody = alert["body"] as? String{
        //                    savedNotificationBody = notificationBody
        //                }
        //                //4
        //                if let notificationTitle = alert["title"] as? String{
        //                    savedNotificationTitle = notificationTitle
        //                }
        //            }
        //        }
        //
        //        print(userInfo["ClearCache"])
        //        if let clearCache = userInfo["ClearCache"] as? String {
        //            if clearCache == "true"{
        //                UserDefaults.standard.set(clearCache, forKey: "isClearCache")
        //                UserDefaults.standard.synchronize()
        //            }
        //        }
        //
        //        let obj = NotificationItems(body: savedNotificationBody, title: savedNotificationTitle, article_id: savedNotificationArticleId, img: savedNotificationImage, ClearCache: false)
        //        RealmService.shared.create(obj)
        
        // Change this to your preferred presentation option
        completionHandler([.alert , .sound])
    }
    
    func getNotificationData(userInfo:NSDictionary){
        var savedNotificationBody = ""
        var savedNotificationTitle = ""
        var savedNotificationImage = ""
        var savedNotificationArticleId = ""
        var savedNotificationTime = 0
        //1
        if let notificationArticleId = userInfo["article_id"] as? String{
            savedNotificationArticleId = notificationArticleId
        }
        //2
        if let notificationImage = userInfo["img"] as? String {
            savedNotificationImage = notificationImage
        }
        if let notificationTime = userInfo["time"] as? String{
            savedNotificationTime = Int(notificationTime)!
        }
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                //3
                if let notificationBody = alert["body"] as? String{
                    savedNotificationBody = notificationBody
                }
                //4
                if let notificationTitle = alert["title"] as? String{
                    savedNotificationTitle = notificationTitle
                }
                //4
               
            }
        }
        
        print(userInfo["ClearCache"])
        if let clearCache = userInfo["ClearCache"] as? String {
            if clearCache == "true"{
                UserDefaults.standard.set(clearCache, forKey: "isClearCache")
                UserDefaults.standard.synchronize()
            }
        }
        
        var dateConverted = Date()
        if let timeInt = savedNotificationTime as? Int {
            dateConverted = Date(timeIntervalSince1970: TimeInterval(Double(timeInt)))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
            let strDate = dateFormatter.string(from: dateConverted)
            dateConverted = dateFormatter.date(from:strDate)!

        }
        
        let obj = NotificationItems(body: savedNotificationBody, title: savedNotificationTitle, article_id: savedNotificationArticleId, img: savedNotificationImage, ClearCache: false , notificationDate: dateConverted)
        RealmService.shared.create(obj)
    }
    
    //open notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        if let articleId = userInfo["article_id"] as? String{
            
            if(articleId != ""){
                openArticle(articleId)
            }
            
        }
        
        //   showNoification(userInfo)
        
        completionHandler()
    }
    
    func openArticle(_ articleId:String)    {
        
        if RootViewController.shared == nil {
            RootViewController.displayArticleWithId = articleId
        } else {
            AppUtils.launchSingleArticleView(articleId: articleId, controller: RootViewController.shared!)
        }
    }
}
// [END ios_10_message_handling]


extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        Messaging.messaging().subscribe(toTopic: topic)
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        Messaging.messaging().subscribe(toTopic: topic)
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        //showNoification(remoteMessage.appData)
    }
    // [END ios_10_data_message]
    
}


