//
//  MemeFetcher.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 24.10.2021.
//

import Foundation
import Combine

extension Meme {
    class Fetcher : ObservableObject{
        enum FetchErrors : Error, LocalizedError{
            case unknown
            case decodeError(reason : String)
            
            var errorDescription: String?{
                switch self {
                case .unknown:
                    return "Unknown Error"
                case .decodeError(let reason):
                    return reason
                }
            }
        }
        
        
        private let url  = URL(string: "https://api.imgflip.com/get_memes")!
        
        func fetchMemes() -> AnyPublisher<Meme, FetchErrors>{
            
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { $0.data }
                .decode(type: Meme.self, decoder: decoder)
                .mapError{
                    error -> FetchErrors in
                    if error is DecodingError {
                        return FetchErrors.decodeError(reason: error.localizedDescription)
                    }
                    
                    return FetchErrors.unknown
                }
                .eraseToAnyPublisher()
            
            
        }
    }
}
