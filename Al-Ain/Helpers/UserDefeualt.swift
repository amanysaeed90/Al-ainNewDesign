//
//  UserDefeualt.swift
//  Al-Ain
//
//  Created by Alex on 10/21/18.
//  Copyright © 2018 egygames. All rights reserved.
//

import UIKit

class UserDefeualt: NSObject {
    struct UserDefaultHelper {
        static let PerviousSearchDataCount = 10
        static let StoredUserDefaultKey = "SavedPrevoiusSearchArray"
        
        static func userAlreadyExist(kUsernameKey: String) -> Bool {
            return UserDefaults.standard.object(forKey: kUsernameKey) != nil
        }
        static func setPreviousSearchData(searchText: String){
            if (userAlreadyExist(kUsernameKey: UserDefaultHelper.StoredUserDefaultKey))
            {
                var myStoredArr = UserDefaults.standard.stringArray(forKey: UserDefaultHelper.StoredUserDefaultKey) ?? [String]()
                guard (myStoredArr.contains(searchText))
                    else {
                        if (myStoredArr.count == UserDefaultHelper.PerviousSearchDataCount)
                        {
                            myStoredArr.removeLast()
                        }
                        myStoredArr.insert(searchText, at: 0)
                        UserDefaults.standard.set(myStoredArr, forKey: UserDefaultHelper.StoredUserDefaultKey)
                        return
                }
                let FoundedIndex = myStoredArr.index(of: searchText)
                myStoredArr.remove(at: FoundedIndex!)
                myStoredArr.insert(searchText, at: 0)
                UserDefaults.standard.set(myStoredArr, forKey: UserDefaultHelper.StoredUserDefaultKey)
            }
            else
            {
                var PrevoisSearchArr = [String]()
                PrevoisSearchArr.insert(searchText, at: 0)
                UserDefaults.standard.set(PrevoisSearchArr, forKey: UserDefaultHelper.StoredUserDefaultKey)
                
            }
            
        }
        static func getPreviousSearchData() -> [String]{
            
            guard (userAlreadyExist(kUsernameKey: UserDefaultHelper.StoredUserDefaultKey)) else {
                return []
            }
            var dtaa = UserDefaults.standard.stringArray(forKey: UserDefaultHelper.StoredUserDefaultKey) ?? [String]()
            print(dtaa)

            return UserDefaults.standard.stringArray(forKey: UserDefaultHelper.StoredUserDefaultKey) ?? [String]()
            
        }
        
        
        
    }
    
}
