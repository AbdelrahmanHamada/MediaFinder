


import UIKit
import Alamofire

class ApiManager {
    
    static func itunesMediaLoad (dataType: String, searchText: String, handle: @escaping (_ data: ItunesMedia) -> Void) {
        
        AF.request(constants().itunes, method: .get, parameters: ["term" :searchText, "media" : dataType], encoding: URLEncoding.default, headers: nil).response {
            response in
        switch response.result {
                 
             case .failure(_) :
                    print("err")
             case .success(_) :
                 
                 do {
                 let decoder = JSONDecoder()
                 let media = try decoder.decode(ItunesMedia.self, from: response.data!)
                        handle(media)
                 } catch {
                     print(error)
                 }
            
        }
        }
    }
}

