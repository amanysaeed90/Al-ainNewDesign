import Foundation
import AlamofireObjectMapper
import Alamofire
import RealmSwift
import Realm
extension APIManager{
    
    
    static func  getTaxonimies( suceess: @escaping (_ result: TaxonomyResponse) -> Void, failure: @escaping (Error?) -> Void) {
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getTaxonimies(secretKey: secretKey, suceess: suceess, failure: failure)
        }
    }
    private static func  getTaxonimies(secretKey:String, suceess: @escaping (_ result: TaxonomyResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let urlComponents = NSURLComponents(string: APIManager.taxonomiesURL)!
        urlComponents.queryItems = [URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)]
        var mutableURLRequest = URLRequest(
            url:urlComponents.url!,
            cachePolicy: getChachPolicy() ,
            timeoutInterval:60
        )
        mutableURLRequest.httpMethod = "GET"
        
        Alamofire.request( mutableURLRequest ).responseObject {
            (response: DataResponse<TaxonomyResponse>) -> Void in
            
            switch response.result {
            case .success(_):
                let taxs:TaxonomyResponse = response.result.value!
                for taxonomy in taxs.sections {
                    taxonomy.type = .SECTION
                    taxonomy.taxType = "category"
                    
                }
                for taxonomy in taxs.countries {
                    taxonomy.type = .COUNTRY
                    taxonomy.taxType = "countries"

                }
                for taxonomy in taxs.tags {
                    taxonomy.type = .TAG
                    taxonomy.taxType = "tags"

                }
                for taxonomy in taxs.pages {
                    taxonomy.type = .PAGE
                    taxonomy.taxType = "page"

                }
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(taxs,update: true)
                    }
                }
                catch let error as NSError {
                }
                suceess( taxs)
            case .failure(let error):
                failure(error as NSError?)
            }
            
        }
    }
    static func  getMoreTaxonimies(_ taxonomyType:TaxonomyType  ,page:Int , suceess: @escaping (_ result: List<Taxonomy>) -> Void, failure: @escaping (Error?) -> Void){
        SecretKeyManager.shared.fetchConfig { (secretKey) in
            getMoreTaxonimies(secretKey: secretKey, taxonomyType:taxonomyType  ,page:page,  suceess: suceess, failure: failure)
        }
    }
    private static func  getMoreTaxonimies(secretKey: String, taxonomyType:TaxonomyType  ,page:Int , suceess: @escaping (_ result: List<Taxonomy>) -> Void, failure: @escaping (Error?) -> Void) {
        
        let urlComponents = NSURLComponents(string:   APIManager.getTaxonomiesURLForTaxonmeyType(taxonomyType ))
        urlComponents?.queryItems =
            [URLQueryItem(name:APIManager.pageParamter, value:String(page)),
             URLQueryItem(name:APIManager.secretKeyParamter, value:secretKey)
        ]
        
        
        
        let mutableURLRequest = URLRequest(
            url: (urlComponents?.url!)!,
            cachePolicy: getChachPolicy() ,
            timeoutInterval:60
        )
        
        Alamofire.request( mutableURLRequest )
            .responseObject {
                (response: DataResponse<TaxonomyResponse>) -> Void in
                
                switch response.result {
                case .success(_):
                    let taxs:TaxonomyResponse = response.result.value!
                    
                    
                    for taxonomy in taxs.sections {
                        taxonomy.type = .SECTION
                        taxonomy.taxType = "category"
                    }
                    for taxonomy in taxs.countries {
                        taxonomy.type = .COUNTRY
                        taxonomy.taxType = "countries"

                    }
                    for taxonomy in taxs.tags {
                        taxonomy.type = .TAG
                        taxonomy.taxType = "tags"
                    }
                    for taxonomy in taxs.pages {
                        taxonomy.type = .PAGE
                        taxonomy.taxType = "page"
                    }
                    switch taxonomyType {
                    case .SECTION:
                        suceess( taxs.sections)
                        break
                    case .PAGE:
                        suceess( taxs.pages)
                        break
                    case .TAG:
                        suceess( taxs.tags)
                        break
                    case .COUNTRY:
                        suceess( taxs.countries)
                        break
                    default :
                        suceess( List<Taxonomy>())
                        break
                    }
                case .failure(let error):
                    failure(error as NSError?)
                }
        }
    }
    static func  getTaxonomiesURLForTaxonmeyType(_ taxonomyType:TaxonomyType  )->String{
        
        switch taxonomyType {
            
        case .SECTION:
            return APIManager.moreSectionsUrl
        case .PAGE:
            return APIManager.morePagesUrl
        case .TAG:
            return APIManager.moreTagsUrl
        case .COUNTRY:
            return APIManager.moreCountriesUrl
        default :
            return APIManager.moreSectionsUrl
            
        }
        
    }
    
    
    
    
    
}
