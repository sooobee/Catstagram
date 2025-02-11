//
//  FeedUploadModel.swift
//  Catstagram
//
//  Created by 김수비 on 2/3/25.
//

// API에서 받는 것
struct FeedUploadModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult
}

struct FeedUploadResult : Decodable {
    var postIdx : Int
}
