//
//  Message.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import Foundation

struct MessageResponse: Codable{
    let msgCode: String
    let msgContent: String
    let result: MessageList
}

struct MessageList: Codable {
    let messages: [Message]?
}

struct Message: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

extension Message {
    static func getURL() -> Resource<MessageResponse> {
        let urlString = "https://willywu0201.github.io/data/notificationList.json"
        return Resource<MessageResponse>(urlString: urlString)
    }
}
