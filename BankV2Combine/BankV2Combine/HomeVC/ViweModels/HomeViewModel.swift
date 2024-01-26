//
//  HomeViewModel.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/24.
//

import Foundation
import Combine

class HomeViewModel {
    
    @Published private(set) var balanceResult: BalanceResult = .init(totalUSD: "", totalKHR: "")
    @Published var balanceLoadingCompleted = false
    @Published private(set) var urls: [URL] = []
    @Published var adLoadingCompleted = false
    @Published private(set) var favoriteItems: [Item] = []
    @Published var favoriteLoadingCompleted = false
    @Published private(set) var messages: [Message] = []
    @Published var messageLoadingCompleted = false
    @Published private(set) var error: NetworkError?
    private let webService: Webservice
    
    private var cancellables = Set<AnyCancellable>()
    
    init(webService: Webservice) {
        self.webService = webService
        loadBalance()
        loadAds()
    }
    
    private func loadBalance(isNew: Bool = false) {
        
        let usdAccountPublisher = getAccounts(type: .USD, isNew: isNew)
        let khrAccountPublisher = getAccounts(type: .KHR, isNew: isNew)
        
        Publishers.CombineLatest(usdAccountPublisher, khrAccountPublisher)
            .sink { [unowned self] completion in
                switch completion {
                    
                case .finished:
                    self.balanceLoadingCompleted = true
                case .failure(let error):
                    self.error = (error as! NetworkError)
                }
            } receiveValue: { [unowned self] (usdAccounts, khrAccounts) in
                let totalUSD = self.calculateToctalBalance(accounts: usdAccounts.filter{$0.curr == .USD}) + self.calculateToctalBalance(accounts: khrAccounts.filter{$0.curr == .USD})
                let totalKHR = self.calculateToctalBalance(accounts: usdAccounts.filter{$0.curr == .KHR}) + self.calculateToctalBalance(accounts: khrAccounts.filter{$0.curr == .KHR})
                self.balanceResult = BalanceResult(totalUSD: totalUSD.toCurrencyString(), totalKHR: totalKHR.toCurrencyString())
            }.store(in: &cancellables)

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
    
    private func loadAds() {
        webService.fetchBanners(resource: Banner.getURL())
            .map { banners in
                banners.map {URL(string: $0.linkUrl)!}
            }
            .sink { [unowned self] completion in
                switch completion {
                    
                case .finished:
                    self.adLoadingCompleted = true
                case .failure(let error):
                    self.error = (error as! NetworkError)
                }
            } receiveValue: { [unowned self] urls in
                self.urls = urls
            }.store(in: &cancellables)

    }
    
    private func loadFavorite() {
        webService.fetchFavorites(resource: Item.getURL())
            .sink { [unowned self] completion in
                switch completion {
                    
                case .finished:
                    self.favoriteLoadingCompleted = true
                case .failure(let error):
                    self.error = (error as! NetworkError)
                }
            } receiveValue: { [unowned self] items in
                self.favoriteItems = items
            }.store(in: &cancellables)

    }
    
    private func loadMessages() {
        webService.fetchMessages(resource: Message.getURL())
            .sink { [unowned self] completion in
                switch completion {
                    
                case .finished:
                    self.messageLoadingCompleted = true
                case .failure(let error):
                    self.error = (error as! NetworkError)
                }
            } receiveValue: { [unowned self] messages in
                self.messages = messages
            }.store(in: &cancellables)

    }
    
    func refresh() -> AnyPublisher<Bool, Never> {
        balanceLoadingCompleted = false
        balanceResult = BalanceResult(totalUSD: "", totalKHR: "")
        loadBalance(isNew: true)
        loadFavorite()
        loadMessages()
        return Publishers.CombineLatest3($balanceLoadingCompleted, $favoriteLoadingCompleted, $messageLoadingCompleted)
            .flatMap { (balanceCompleted, favoriteCompleted, messageCompleted) in
                if balanceCompleted && favoriteCompleted && messageCompleted {
                    return Just(true)
                }
                return Just(false)
            }.eraseToAnyPublisher()
            
    }
}
