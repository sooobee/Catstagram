//
//  FeedAPIInput.swift
//  Catstagram
//
//  Created by 김수비 on 2/3/25.
//

// MARK: 내가 API에게 보내주는 것들
import Foundation
struct FeedAPIInput : Encodable {
    var limit : Int?
    var page : Int?
    
}
