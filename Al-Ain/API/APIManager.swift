import Foundation
import SystemConfiguration
import Localize_Swift



let ReachabilityStatusChangedNotification = "ReachabilityStatusChangedNotification"

enum ReachabilityType: CustomStringConvertible {
    case wwan
    case wiFi
    
    var description: String {
        switch self {
        case .wwan: return "WWAN"
        case .wiFi: return "WiFi"
        }
    }
}

enum ReachabilityStatus: CustomStringConvertible  {
    case offline
    case online(ReachabilityType)
    case unknown
    
    var description: String {
        switch self {
        case .offline: return "Offline"
        case .online(let type): return "Online (\(type))"
        case .unknown: return "Unknown"
        }
    }
}

public class Reach {
    
    func connectionStatus() -> ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .unknown
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .unknown
        }
        
        return ReachabilityStatus(reachabilityFlags: flags)
    }
    
    
    func monitorReachabilityChanges() {
        let host = "google.com"
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        let reachability = SCNetworkReachabilityCreateWithName(nil, host)!
        
        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
            let status = ReachabilityStatus(reachabilityFlags: flags)
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: ReachabilityStatusChangedNotification),
                                            object: nil,
                                            userInfo: ["Status": status.description])
            
            }, &context)
        
        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), RunLoopMode.commonModes as CFString)
    }
    
}

extension ReachabilityStatus {
    init(reachabilityFlags flags: SCNetworkReachabilityFlags) {
        let connectionRequired = flags.contains(.connectionRequired)
        let isReachable = flags.contains(.reachable)
        let isWWAN = flags.contains(.isWWAN)
        
        if !connectionRequired && isReachable {
            if isWWAN {
                self = .online(.wwan)
            } else {
                self = .online(.wiFi)
            }
        } else {
            self =  .offline
        }
    }
}



final  class APIManager {
    
    static let localizeLang = Localize.currentLanguage()
    static func  getbaseURL() -> String{
        if (localizeLang == "ar")
        {
          return  "https://al-ain.net/api/v4/"
        }
        else
        {
           return "https://\(localizeLang).al-ain.net/api/v4/"
        }
        
    }
    static let baseURL = getbaseURL()
   
    static let taxonomiesURL = baseURL + "taxonomy/"
    
    static let moreSectionsUrl = taxonomiesURL + "sections/"
    
    static let moreTagsUrl = taxonomiesURL + "hashtags/"
    
    static let moreCountriesUrl = taxonomiesURL + "countries/"
    
    static let morePagesUrl = taxonomiesURL + "pages/"
  
    static let sectionArticlesURL = baseURL + "section/"
    static let pageArticlesURL = baseURL + "page/"
    static let countryArticlesURL = baseURL + "country/"
    static let tagArticlesURL = baseURL + "tag/"
    
    static let homeArticlesURL = baseURL + "home/"
    static let myNewsURL = baseURL + "mynews/"
    static let openionsArticlesURL = baseURL + "opinions/"
    static let videosArticlesURL = baseURL + "videos/"
    static let infographArticlesURL = baseURL + "infographics/"
    static let articleDetailsURL = baseURL + "article/"
    static let relatedArticlesURL = baseURL + "article/%@/related"
    static let photosURL =  baseURL + "photosnewsstory/"
    static let featuredURL = baseURL + "featured/"
    static let trendsURL = baseURL + "trends/"
    static let pageParamter =  "page"
    static let corona = baseURL + "page/221615"

    
    static let secretKeyParamter = "secret"
    static let networkConnectionError =    "NetWorkFailed".localized()
      static let   MAX_COUNT = 12
    
   
    static func  getChachPolicy() -> NSURLRequest.CachePolicy {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            return  NSURLRequest.CachePolicy.returnCacheDataDontLoad
        case .online(.wwan), .online(.wiFi):
            return NSURLRequest.CachePolicy.useProtocolCachePolicy

        }
        return .reloadIgnoringLocalCacheData
        
    }
}
