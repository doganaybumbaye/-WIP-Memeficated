//
//  MemeficatedApp.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 24.10.2021.
//

import SwiftUI

@main
struct MemeficatedApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
 
                TabbarCustomize()


        }
    }
}
