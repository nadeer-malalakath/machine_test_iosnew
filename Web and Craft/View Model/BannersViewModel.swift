
import PromiseKit
import Alamofire
import SwiftyJSON

class BannersViewModel{
    
    class var sharedInstance: BannersViewModel {
        struct Singleton {
            static let instance = BannersViewModel()
        }
        return Singleton.instance
}
    
    
    func getBanners() -> Promise<BannerMain>
    {
        return Promise
            {
                resolver in
               
                    AF.request("https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0",method:.get,parameters:nil,encoding:JSONEncoding.default).responseString { response in
                        
                        print("REQUEST:",response.request?.description ?? "")
                        
                        switch response.result
                        {
                        case.success(let data):
                            if let json = data.data(using: .utf8)
                            {
                                do
                                {
                                    let a = try JSONDecoder().decode(BannerMain.self,from: json)
                                    resolver.fulfill(a)
                                }
                                catch let err
                                {
                                    print("JSONDecoder Error:\n",err)
                                }
                            }
                            
                            // print("my actual response is:",data)
                            
                        case .failure(let error):
                            
                            resolver.reject(error)
                            print("network error:",error)
                        }
                        
                    }
                    
                }
                
        }
   
    }
    
