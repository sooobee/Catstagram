//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by 김수비 on 2/6/25.
//

import Alamofire

// MARK: - 클라이언트와 서버를 연결해주는 역할
class UserFeedDataManager {
    
    func getUserFeed(_ viewController : ProfileViewController, _ userID : Int = 2){
        
        // Alamofire을 사용해 get 요청을 보냄
        // 통신 서버 안됨
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: [UserFeedModel].self){ response in
            
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
