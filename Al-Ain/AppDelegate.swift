import UIKit
import UserNotifications
import Fabric
import Crashlytics
import Firebase
import AlgoliaSearch
import FirebaseRemoteConfig
import FacebookCore
//import TwitterKit
import FBSDKCoreKit
import AVFoundation
import RealmSwift
import DropDown
import Localize_Swift

var badgeCounter = 0
let BadgeCounterNotificationName = Notification.Name("BadgeCounter")
var ApplicationOpen = 0 //to not show vedio in when background then forground // issue case push to root again
@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
   // let viewController = ApplicationRootViewController()
        let viewController = VideoSplashVC()

    var window: UIWindow?
    let articleIdKey = "gcm.notification.article_id"
    let imageNotificationKey = "gcm.notification.img"
    let gcmMessageIDKey = "gcm.message_id"
    let topic = "NewsNotificationsIOS"
    var client:Client!
    var remoteConfig:RemoteConfig!
    //    var badgeCounter = 0
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Localize.setCurrentLanguage("fr")
        if Localize.currentLanguage() == "tr" || Localize.currentLanguage() == "fr" ||
            Localize.currentLanguage() == "am"{
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            // fa // ar
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
         UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
   
        
        
        
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)

        // caching
        let uRLCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
        URLCache.shared = uRLCache
        
        //-----------
        
        
        //
//        if let counter  = UserDefaults.standard.integer(forKey: "badgeCounter"){
//            badgeCounter = counter
//        }else{
//            badgeCounter = 0
//        }
        //
        
        
        Fabric.with([Crashlytics.self])
        setupFirebase(application)
        
        client = Client(appID: "B42561B8AK", apiKey: "c217df5d1041d8795a903977f9b798f5")
        
        
        // load mynews
        MyTaxonomy.myTaxonomies =  MyTaxonomy.load()
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }catch let error as NSError{
            print(error)
        }
        
        let category = UNNotificationCategory(identifier: "myNotificationCategory", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        do{
            try
        FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        }catch{}
        
        
        
        let configCheck = Realm.Configuration();
        let configCheck2 = Realm.Configuration.defaultConfiguration;
        let schemaVersion = configCheck.schemaVersion
        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
        
      
        
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.almajal.alain")!
            .appendingPathComponent("Library/Caches/default3.realm")
        let configuration = Realm.Configuration(fileURL: fileURL,
        schemaVersion: 4,
        migrationBlock: { (migration, schemaVersion) in
            //
            print("Done Migration")
        },
        deleteRealmIfMigrationNeeded: true)

        Realm.Configuration.defaultConfiguration = configuration
        
        
        
        
        // Tell Realm to use this new configuration object for the default Realm
        // h7b546v5q1w 34Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
       // let realm = try! Realm()
        //let realm = try! Realm(configuration: config) // Invoke migration block if needed
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = viewController
        
        //window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        DropDown.startListeningToKeyboard()
//        let navBackgroundImage:UIImage! = UIImage(named: "navigationbg")
//        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, for: .default)
//     

        return true
    }
//    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//RealmManager.shared.configureRealm()
//
//        return true
//    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        let vc: UIViewController = self.window!.rootViewController!

        if (vc == viewController)
        {
        viewController.pauseVideo()
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
       // if viewController.
        let vc: UIViewController = self.window!.rootViewController!

        if (vc == viewController)
        {
         viewController.playVideo()
        }
        UIApplication.shared.applicationIconBadgeNumber = badgeCounter
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = badgeCounter
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        AppEventsLogger.activate(application)
        
    }
    // Swift
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //   if(url.scheme!.contains("fb")){
        return  FBSDKApplicationDelegate.sharedInstance().application(app, open: url,
                                                                      sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,annotation:  options[UIApplicationOpenURLOptionsKey.annotation])
        
        //    }
        //   return Twitter.sharedInstance().application(app, open: url, options: options)
    }
    
    
    
}
