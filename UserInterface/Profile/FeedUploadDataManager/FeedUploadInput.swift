//
//  FeedUploadInput.swift
//  Catstagram
//
//  Created by 김수비 on 2/3/25.
//

// post 요청할 때 보내주는 값
struct FeedUploadInput : Encodable {
    var content : String
    var postImgsUrl : [String]
}
