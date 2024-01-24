//
//  Banner.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import Foundation

struct BannerResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: BannerList
}

struct BannerList: Codable {
    let bannerList: [Banner]
}

struct Banner: Codable {
    let adSeqNo: Int
    let linkUrl: String
}

extension Banner {
    static func getURL() -> Resource<BannerResponse> {
        let urlString = "https://willywu0201.github.io/data/banner.json"
        return Resource<BannerResponse>(urlString: urlString)
    }
}
