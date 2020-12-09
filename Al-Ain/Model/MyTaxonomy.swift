//
//  MyTaxonomy.swift
//
//  Created by imac on 9/12/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import  Realm
import RealmSwift

public final class MyTaxonomy {

    
    static var myTaxonomies:[Taxonomy] = []
    
    static func isTaxonomyInMyTaxonomies(_ tax:Taxonomy) -> Bool {
        for t in myTaxonomies {
            if t.id == tax.id {
                return true
            }
        }
        return false
    }
    
    static func save(_ taxItem:Taxonomy){
        
       // let myTaxonomiesData = NSKeyedArchiver.archivedData(withRootObject: myTaxonomies)
       // UserDefaults.standard.set(myTaxonomiesData, forKey: "myTaxonomies")

       // for item in myTaxonomies{
            
                do{
                    
                let realm = try Realm()
                  try realm.write {
                      //realm.add(item,update: true)
                    //realm.add(myTaxonomies)
                    let allNotifications = realm.objects(MyTaxonomyies.self)
                   // realm.delete(allNotifications)
                    print(myTaxonomies)
                    let tax = MyTaxonomyies(Tax: taxItem)
                    tax?.Tax = taxItem
                    print("///////////")
                    print(tax as Any)
                    if (self.objectExist(id: taxItem.id!))
                    {
                    //realm.delete(tax!)
                            realm.delete(realm.objects(MyTaxonomyies.self).filter("id=%@",taxItem.id!))
                        for (index , t) in  MyTaxonomy.myTaxonomies.enumerated() {
                                        if t.id == taxItem.id {
                                            MyTaxonomy.myTaxonomies.remove(at: index)
                                            break
                                        }
                                    }
                    }
                    else {
                    realm.add(tax!, update: true)
                    }
                    }
                  }
                  catch let error as NSError {
                    print(error)
                  }
       // }
    }
    
    static func RemoveTaxonomy(_ tax:Taxonomy){
        do{
                          
                          let realm = try Realm()
                        try realm.write {
                            realm.delete(tax)
                        }
        }
                        catch let error as NSError {
                          print(error)
                        }
        
    }
    static func objectExist (id: String) -> Bool {
                          
            let realm = try! Realm()
            return realm.object(ofType: MyTaxonomyies.self, forPrimaryKey: id) != nil
    }
    static func load() -> [Taxonomy]{
        
        let realm = try! Realm()
        let TaxResponse = realm.objects(MyTaxonomyies.self)
        var myTaxonomiesArray:[Taxonomy] = []
        for item in TaxResponse
        {
            myTaxonomiesArray.append(item.Tax!)
            
        }
        myTaxonomies = myTaxonomiesArray
        
        let myTaxonomiesData = UserDefaults.standard.object(forKey:"myTaxonomies") as? NSData
        
//        if let myTaxonomiesData = myTaxonomiesData {
//            let  myTaxonomiesArray = NSKeyedUnarchiver.unarchiveObject(with: myTaxonomiesData as Data) as? [Taxonomy]
//
//            return  myTaxonomiesArray!
//
//        }
        return myTaxonomies
    }
    static func add(_ tax:Taxonomy){
        myTaxonomies.append(tax)
        save(tax)
    }
    
    static func asJson() ->Data{
        
        let requestBodyObj:MyNewsRequestBody =  MyNewsRequestBody()
         var myTaxonomiesArray:[Taxonomy] = self.load()
        requestBodyObj.taxonomiesArray = myTaxonomies
       
        do{
//                            let realm = try! Realm()
//                            try! realm.write {
            return  try JSONSerialization.data(withJSONObject: requestBodyObj.toJSON(), options: [])
//            }
//             return Data()
        }catch{
            return Data()
        }
        
    }

    
}


