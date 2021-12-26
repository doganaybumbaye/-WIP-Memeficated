//
//  Meme.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 24.10.2021.
//

import Foundation


struct Meme : Codable{
    let success : Bool
    let data : Meme.Data
}

extension Meme{
    struct Data : Codable {
        let memes : [Meme.Info]
    }
}

extension Meme {
    struct Info: Codable, Hashable{
        
        let id : String?
        let name : String?
        let url : String?
        let widht : Int?
        let height : Int?
        let boxCount : Int?
    }
}


extension Meme.Info {
static var fakeMeme = Meme.Info(
    id: "183518946",
    name: "Blank Transparent Square",
    url: "https://i.imgflip.com/319g4i.png",
    widht: 1000,
    height: 1000,
    boxCount : 2
   )
}

