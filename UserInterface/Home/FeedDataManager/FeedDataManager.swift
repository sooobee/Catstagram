//
//  FeedDataManager.swift
//  Catstagram
//
//  Created by 김수비 on 2/3/25.
//

import Alamofire

// MARK: - 클라이언트와 서버를 연결해주는 역할
class FeedDataManager {
    
    func FeedDataManager(_ parameter : FeedAPIInput, _ viewController : HomeViewController){
        // Alamofire을 사용해 get 요청을 보냄
        AF.request("https://api.thecatapi.com/v1/images/search?api_key=live_HW2y3caYyriFME7r76QoVCt5LK7By61c8JT7AZc39Vd66lUhXTtOcGsOhpdrdS2Z",
                   method: .get, parameters: parameter).validate().responseDecodable(of: [FeedModel].self){ response in
            
            switch response.result {
            case .success(let result):
                viewController.successAPI(result)
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
}
