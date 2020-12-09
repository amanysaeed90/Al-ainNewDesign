import Foundation
import AlamofireObjectMapper
import Alamofire

extension APIManager{
    
    static  func getArticles(taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
        
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getArticles(secretKey:secretKey,taxonomy:taxonomy  ,page:page , suceess:suceess, failure: failure)
        }
        
    }
    static  func getArticlesOpenion(taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
        
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getArticlesOpenion(secretKey:secretKey,taxonomy:taxonomy  ,page:page , suceess:suceess, failure: failure)
        }
        
    }
    private static  func getArticles(secretKey:String,taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
        print(taxonomy)
        
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
    
    static  func getArticlesPages(taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
        
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getArticlesPages(secretKey:secretKey,taxonomy:taxonomy  ,page:page , suceess:suceess, failure: failure)
        }
        
    }
    
    private static  func getArticlesPages(secretKey:String,taxonomy:Taxonomy!  ,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
           print(taxonomy)
           
           let urlComponents = NSURLComponents(string:   APIManager.getAPIURLForTaxonmeyTypes(taxonomy:taxonomy) )!
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
    
    
    
    private static  func getArticlesOpenion(secretKey:String,taxonomy:Taxonomy!,page:Int , suceess: @escaping (_ result: [Article]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let urlComponents = NSURLComponents(string: APIManager.baseURL+"author/\(taxonomy.id ?? "0")" )!
        urlComponents.queryItems = [URLQueryItem(name:APIManager.pageParamter, value:String(page)) ,
                                    URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)  ]
        
        
        
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
    
    
    
    static func  getAPIURLForTaxonmeyType(taxonomy:Taxonomy!  )->String{
        
        switch taxonomy.type {
            
        case .SECTION:
            return APIManager.sectionArticlesURL + taxonomy.id!
        case .PAGE:
            return APIManager.pageArticlesURL + taxonomy.id!
        case .TAG:
            return APIManager.tagArticlesURL + taxonomy.id!
        case .COUNTRY:
            return APIManager.countryArticlesURL + taxonomy.id!
        case .OPONION:
            return APIManager.openionsArticlesURL
        case .HOME:
            return APIManager.homeArticlesURL
        case .MYNEWS:
            return APIManager.myNewsURL
        case .VIDEO:
            return APIManager.videosArticlesURL
        case .INFOGRAPH:
            return APIManager.infographArticlesURL
        case .PHOTO:
            return APIManager.photosURL
        case .Trend:
            return APIManager.trendsURL
        case .Featured :
            return APIManager.featuredURL
        case .Corona :
            return APIManager.corona
        case .none:
           return APIManager.sectionArticlesURL + taxonomy.id!

        }
        
    }
    static func  getAPIURLForTaxonmeyTypes (taxonomy:Taxonomy!  )->String{
        
        switch taxonomy.taxType {
            
        case "category":
            return APIManager.sectionArticlesURL + taxonomy.id!
        case "countries":
            return APIManager.countryArticlesURL + taxonomy.id!
        case "tags":
            return APIManager.tagArticlesURL + taxonomy.id!
        case "page":
            return APIManager.pageArticlesURL + taxonomy.id!
                
        case .none:
           return APIManager.sectionArticlesURL + taxonomy.id!

        case .some(_):
            return APIManager.sectionArticlesURL + taxonomy.id!
        }
        
    }
}
