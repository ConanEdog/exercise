//
//  HomeViewModel.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/24.
//

import Foundation
import Combine

class HomeViewModel {
    
    struct InitOutput {
        let balanceResultPublisher: AnyPublisher<BalanceResult, Error>
        let adPublisher: AnyPublisher<[URL], Error>
    }
    
    struct RefreshOutput {
        let balanceResultPublisher: AnyPublisher<BalanceResult, Error>
    }
    
    private let webService: Webservice
    
    private var cancellables = Set<AnyCancellable>()
    
    init(webService: Webservice) {
        self.webService = webService
        
    }
    
    func output() -> InitOutput {
        let balanceResult = loadBalance()
        let adResult = loadAds()
        return InitOutput(balanceResultPublisher: balanceResult, adPublisher: adResult)
    }
    
    func refreshOutput() -> RefreshOutput {
        let balanceResult = loadBalance(isNew: true)
        return RefreshOutput(balanceResultPublisher: balanceResult)
    }
    
    private func loadBalance(isNew: Bool = false) -> AnyPublisher<BalanceResult, Error> {
        
        let usdAccountPublisher = getAccounts(type: .USD, isNew: isNew)
        let khrAccountPublisher = getAccounts(type: .KHR, isNew: isNew)
        
        let balancePublisher = Publishers.CombineLatest(usdAccountPublisher, khrAccountPublisher)
            .flatMap {[unowned self] (usdAccounts, khrAccounts) in
                let totalUSD = self.calculateToctalBalance(accounts: usdAccounts.filter{$0.curr == .USD}) + self.calculateToctalBalance(accounts: khrAccounts.filter{$0.curr == .USD})
                let totalKHR = self.calculateToctalBalance(accounts: usdAccounts.filter{$0.curr == .KHR}) + self.calculateToctalBalance(accounts: khrAccounts.filter{$0.curr == .KHR})
                return Just(BalanceResult(totalUSD: totalUSD, totalKHR: totalKHR))
            }.eraseToAnyPublisher()
        
        
        return balancePublisher
        
    }
    
    private func getAccounts(type: CurrencyType, isNew: Bool) -> AnyPublisher<[Account], Error> {
        
        let savingPublisher = webService.fetchAccounts(resource: Account.getURL(currencyType: type, accountType: .saving, isNew: isNew), accountType: .saving)
        let fixedPublisher = webService.fetchAccounts(resource: Account.getURL(currencyType: type, accountType: .fixed, isNew: isNew), accountType: .fixed)
        let digitPublisher = webService.fetchAccounts(resource: Account.getURL(currencyType: type, accountType: .digital, isNew: isNew), accountType: .digital)
        
        let publisher = Publishers.CombineLatest3(savingPublisher, fixedPublisher, digitPublisher)
            .flatMap { (savings, fixeds, digits) in
                let merge = savings + fixeds + digits
                return Just(merge)
            }.eraseToAnyPublisher()
        return publisher
    }
    
    
    private func calculateToctalBalance(accounts: [Account]) -> Double {
        var total: Double = 0
        for account in accounts {
            total += account.balance
        }
        return total
    }
    
    private func loadAds() -> AnyPublisher<[URL], Error> {
        return webService.fetchBanners(resource: Banner.getURL())
            .flatMap { banners in
                Just(banners.map { URL(string: $0.linkUrl)!})
            }.eraseToAnyPublisher()
        
    }
    
}
