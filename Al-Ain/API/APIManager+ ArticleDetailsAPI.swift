import Foundation
import AlamofireObjectMapper
import Alamofire

extension APIManager{
    
    static  func getArticleDetails(id:String, suceess: @escaping (_ result: Article) -> Void, failure: @escaping (Error?) -> Void) {
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getArticleDetails(secretKey:secretKey,id:id, suceess:suceess, failure: failure)
        }
    }
    private  static  func getArticleDetails(secretKey:String,id:String, suceess: @escaping (_ result: Article) -> Void, failure: @escaping (Error?) -> Void) {
        
        let urlComponents = NSURLComponents(string: APIManager.articleDetailsURL + id )!
        urlComponents.queryItems = [URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)]
        
        
        var mutableURLRequest = URLRequest(
            url: urlComponents.url!,
            cachePolicy: getChachPolicy() ,
            timeoutInterval:60
        )
        mutableURLRequest.httpMethod = "GET"
        
        Alamofire.request( mutableURLRequest)
            .responseObject {
                (response: DataResponse<Article>) -> Void in
                
                switch response.result {
                    
                case .success(_):
                    
                    suceess( response.result.value!)
                case .failure(let error):
                    failure(error as NSError?)
                }
                
        }
    }
    
    
    
    
    
    
}
