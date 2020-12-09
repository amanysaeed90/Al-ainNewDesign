//
//  SecretKeyManager.swift
//  Al-Ain
//
//  Created by imac on 10/3/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class SecretKeyManager {
    var remoteConfig: RemoteConfig!
     let ttlKey = "ttl"
    let secretKey = "secret"
    
    static let shared = SecretKeyManager()
    private init(){
        
        remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaults(fromPlist: "RemoteSecretKeyDefault")
        
    }
    
    
    
    func fetchConfig( suceess: @escaping (_ result: String) -> Void) {
        
        let expirationDuration:UInt64 = remoteConfig.configValue(forKey: ttlKey ).numberValue as! UInt64
       
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activateFetched()
            }
            suceess(self.remoteConfig.configValue(forKey: self.secretKey).stringValue!)

        }
    }
}
