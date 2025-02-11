//
//  FeedUploadDataManger.swift
//  Catstagram
//
//  Created by 김수비 on 2/3/25.
//

import Alamofire

// 이미지 업로드 도우미
class FeedUploadDataManger {
    func posts(_ parameter: FeedUploadInput, _ viewController : HomeViewController){
        
        AF.request("https://edu-api-ios-test.softsquared.com/posts",
                   method: .post, 
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default, 
                   headers: nil).validate()
            .responseDecodable(of: FeedUploadModel.self) { response in
                switch response.result {
                case .success(let result):
                    if result.isSuccess {
                        print("성공")
                    } else {
                        print(result.message)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
