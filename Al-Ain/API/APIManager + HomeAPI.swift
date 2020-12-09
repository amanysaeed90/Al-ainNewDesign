import Foundation
import AlamofireObjectMapper
import Alamofire

extension APIManager{
    
    
    static  func getHome(  page:Int , suceess: @escaping (_ result: HomeResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
          SecretKeyManager.shared.fetchConfig { (secretKey) in
            getHome(secretKey:secretKey,page:page , suceess:suceess, failure: failure)
        }
        
    }
    
    
    private static  func getHome( secretKey:String, page:Int , suceess: @escaping (_ result: HomeResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
        let urlComponents = NSURLComponents(string:   APIManager.homeArticlesURL )!
        print(APIManager.baseURL)
        if page != 0 {
            urlComponents.queryItems = [URLQueryItem(name:APIManager.pageParamter, value:String(page)),
                                        URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)         ]
        }
        
        
        
        var mutableURLRequest = URLRequest(
            url: urlComponents.url!,
            cachePolicy: getChachPolicy() ,
            timeoutInterval:60
        )
        
        mutableURLRequest.httpMethod = "GET"
        print(mutableURLRequest)
        print(urlComponents)
        Alamofire.request( mutableURLRequest )
            .responseObject {
                (response: DataResponse<HomeResponse>) -> Void in
      
                switch response.result {
                case .success(_):
                  //  print(response.result.value!)
                    suceess( response.result.value!)
                case .failure(let error):
                    failure(error as NSError?)
                }
                
        }
    }
    
    
    static  func getArticlesTrend(taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
          
          SecretKeyManager.shared.fetchConfig { (secretKey) in
              getArticlesTrend(secretKey:secretKey,taxonomy:taxonomy  ,page:page , suceess:suceess, failure: failure)
          }
          
      }
    private static  func getArticlesTrend(secretKey:String,taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
         
         let urlComponents = NSURLComponents(string:   APIManager.getAPIURLForTaxonmeyType(taxonomy:taxonomy) )!
         urlComponents.queryItems = [URLQueryItem(name:APIManager.pageParamter, value:String(page)) ,
                                     URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)        ]
         
         
         
         var mutableURLRequest = URLRequest(
             url: urlComponents.url!,
             cachePolicy: getChachPolicy() ,
             timeoutInterval:60
             
         )
         mutableURLRequest.httpMethod = "GET"
         
         
         Alamofire.request( mutableURLRequest )
             .responseArray {
                 (response: DataResponse<[Article]>) -> Void in
                 
                 switch response.result {
                     
                 case .success(_):
                     
                     suceess( response.result.value!)
                 case .failure(let error):
                     failure(error as NSError?)
                 }
                 
         }
     }
     
}
