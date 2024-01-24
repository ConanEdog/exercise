//
//  Favorite.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import Foundation

enum TransType: String, Codable {
    case CUBC
    case Mobile
    case PMF
    case CreditCard
}


struct FavoriteResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteList
}

struct FavoriteList: Codable {
    let favoriteList: [Item]?
}

struct Item: Codable {
    let nickname: String
    let transType: TransType
}

extension Item {
    
    static func getURL() -> Resource<FavoriteResponse> {
        let urlString = "https://willywu0201.github.io/data/favoriteList.json"
        return Resource<FavoriteResponse>(urlString: urlString)
    }
}
