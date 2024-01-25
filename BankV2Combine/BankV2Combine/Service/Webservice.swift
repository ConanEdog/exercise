//
//  Webservice.swift
//  BankV2Combine
//
//  Created by 方奎元 on 2024/1/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    
    var description: String {
        switch self {
            
        case .decodingError:
            "Decoding Error"
        case .domainError:
            "Server Error"
        case .urlError:
            "URL Error"
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let urlString: String
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
    init(urlString: String) {
        self.urlString = urlString
    }
}

class Webservice {
    
    func fetchAccounts(resource: Resource<AmountResponse>, accountType: AccountType) -> AnyPublisher<[Account], Error> {
        
        let accounts: KeyPath<AmountResponse, [Account]>
        switch accountType {
            
        case .saving:
            accounts = \.result.savingsList!
        case .fixed:
            accounts = \.result.fixedDepositList!
        case .digital:
            accounts = \.result.digitalList!
        }
        
        guard let url = URL(string: resource.urlString) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AmountResponse.self, decoder: JSONDecoder())
            .map(accounts)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMessages(resource: Resource<MessageResponse>) -> AnyPublisher<[Message], Error> {
        
        guard let url = URL(string: resource.urlString) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MessageResponse.self, decoder: JSONDecoder())
            .compactMap(\.result.messages)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
    
    func fetchFavorites(resource: Resource<FavoriteResponse>) -> AnyPublisher<[Item], Error> {
        
        guard let url = URL(string: resource.urlString) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FavoriteResponse.self, decoder: JSONDecoder())
            .map(\.result.favoriteList!)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
    
    func fetchBanners(resource: Resource<BannerResponse>) -> AnyPublisher<[Banner], Error> {
        
        guard let url = URL(string: resource.urlString) else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: BannerResponse.self, decoder: JSONDecoder())
            .map(\.result.bannerList)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                return NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
    
}
