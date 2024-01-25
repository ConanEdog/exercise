//
//  MessageListViewModel.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/25.
//

import Foundation

class MessageListViewModel {
    var messages: [Message]
    
    init(messages: [Message]) {
        self.messages = messages
    }
    
    func mesaage(at index: Int) -> Message {
        return messages[index]
    }
    
    func numberOfRows(_ section: Int) -> Int {
        messages.count
    }
    
}
