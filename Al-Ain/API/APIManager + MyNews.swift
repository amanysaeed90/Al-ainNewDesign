//
//  APIManager + MyNews.swift
//  Al-Ain
//
//  Created by imac on 9/19/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import Foundation
import AlamofireObjectMapper
import Alamofire
import AlgoliaSearch
import RealmSwift




extension APIManager {
    static  func getMyNews(  page:Int , suceess: @escaping (_ result: [JSONObject]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let urlComponents = NSURLComponents(string:   APIManager.myNewsURL )!
        if page != 0 {
            urlComponents.queryItems = [URLQueryItem(name:APIManager.pageParamter, value:String(page))        ]
        }
        var mutableURLRequest = URLRequest(
            url: urlComponents.url!,
            cachePolicy: getChachPolicy(),//.reloadIgnoringLocalAndRemoteCacheData,//getChachPolicy() ,
            timeoutInterval:60
        )
        let realm = try! Realm()
        let TaxResponse = realm.objects(MyTaxonomyies.self)
        var newUploadFilesArray = [AnyObject]()
        for item in TaxResponse {
            if let taxx = item.Tax {
                let taxResult = realm.objects(Taxonomy.self).filter("name == %@", taxx.name)
                let taxRsul=taxResult.first!
            let singleitem = ["name" : taxRsul.name , "type" : taxRsul.taxType , "id" : taxRsul.id]
            newUploadFilesArray.append(singleitem as AnyObject)
            }
        }
        let body: [String: AnyObject] = [
               "taxonomies": newUploadFilesArray as AnyObject
           ]
        
        mutableURLRequest.httpMethod = "POST"
        mutableURLRequest.httpBody = MyTaxonomy.asJson()
        print("MyTaxonomy.asJson()")
        print(MyTaxonomy.asJson())
        print(MyTaxonomy.self)
        mutableURLRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        print(body)
        
        let headers: HTTPHeaders = [
                   "Content-Type":"application/json",
               ]
        
        let params: Parameters = ["taxonomies":newUploadFilesArray]
        Alamofire.request(APIManager.myNewsURL, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers)
            .responseJSON {   response in
        
                switch response.result {
                    
                case .success(_):
                    if let result = response.result.value {
                        
                     let jSON = result as! JSONObject
                        var result = (jSON["hits"] as? [JSONObject])!
                        suceess((jSON["hits"] as? [JSONObject])!)
                    }
                case .failure(let error):
                    failure(error as NSError?)
                }
                
        }
   
    
    }
    static  func getMyNewsFilter(  page:Int ,object :[AnyObject], suceess: @escaping (_ result: [JSONObject]) -> Void, failure: @escaping (Error?) -> Void) {
           
           let urlComponents = NSURLComponents(string:APIManager.myNewsURL )!
           if page != 0 {
               urlComponents.queryItems = [URLQueryItem(name:APIManager.pageParamter, value:String(page))        ]
           }
           
           
           var mutableURLRequest = URLRequest(
               url: urlComponents.url!,
               cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,//getChachPolicy() ,
               timeoutInterval:60
           )
           
      
           let headers: HTTPHeaders = [
                      "Content-Type":"application/json",
                      
                  ]
           let params: Parameters = ["taxonomies":object]
       
           Alamofire.request(APIManager.myNewsURL, method: .post, parameters: params, encoding: JSONEncoding.default,headers: headers)

     
               .responseJSON {   response in
               
                   switch response.result {
                       
                   case .success(_):
                       if let result = response.result.value {
                           
                        let jSON = result as! JSONObject
                           var result = (jSON["hits"] as? [JSONObject])!
                           suceess((jSON["hits"] as? [JSONObject])!)
                       }
                   case .failure(let error):
                       failure(error as NSError?)
                   }
                   
           }
      
       
       }


}
