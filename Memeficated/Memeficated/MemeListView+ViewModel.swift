//
//  MemeListView+ViewModel.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 25.10.2021.
//

import Foundation
import Combine

extension MemeListView {
    
    class ViewModel : ObservableObject{
        @Published var memes : [Meme.Info] = []
        @Published var searchRes : [Meme.Info] = []
        private let memeFetcher = Meme.Fetcher()
        
        private var disposables = Set<AnyCancellable>()
        
        

        
        
        func fetchMemes(){
            memeFetcher.fetchMemes()
                .receive(on: DispatchQueue.main)
                .sink { (completion) in
                    switch completion{
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { (memes) in
                   
                    self.memes = memes.data.memes
                    }
            
                .store(in: &disposables)
                }

            
            
                
        }
    }

