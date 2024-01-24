//
//  Balance.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import Foundation

enum AccountType {
    case saving
    case fixed
    case digital
}

enum CurrencyType: String, Codable, CaseIterable {
    case USD
    case KHR
}


struct AmountResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: ResultList
}

struct ResultList: Codable {
    let savingsList: [Account]?
    let fixedDepositList: [Account]?
    let digitalList: [Account]?
    
}

struct Account: Codable {
    let account: String
    let curr: CurrencyType
    let balance: Double
}

extension Account {
    
    static func getURL(currencyType: CurrencyType, accountType: AccountType, isNew: Bool = false) -> Resource<AmountResponse> {
        if isNew {
            
            switch accountType {
                
            case .saving:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Savings2.json"
                return Resource(urlString: urlString)
                
            case .fixed:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Fixed2.json"
                return Resource(urlString: urlString)
                
            case .digital:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Digital2.json"
                return Resource(urlString: urlString)
            }
            
        } else {
            
            switch accountType {
                
            case .saving:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Savings1.json"
                return Resource(urlString: urlString)
                
            case .fixed:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Fixed1.json"
                return Resource(urlString: urlString)
                
            case .digital:
                let urlString = "https://willywu0201.github.io/data/\(currencyType.rawValue.lowercased())Digital1.json"
                return Resource(urlString: urlString)
            }
        }
    }
    
}
