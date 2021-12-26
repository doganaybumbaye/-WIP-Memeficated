//
//  ContentView.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 24.10.2021.
//

import SwiftUI

final class KeyboardResponder: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.keyboardHeight, on: self)
    }
}

struct MemeListView: View {
    @State private var searchText = ""
    
    
    @StateObject var viewRouter = ViewRouter()
    @ObservedObject var viewModel = ViewModel()
    
    var filteredMemes: [Meme.Info] {
        if searchText.isEmpty {
            return viewModel.memes
        } else {
            return viewModel.memes.filter { $0.name?.lowercased().contains(searchText.lowercased()) as! Bool }
        }
    }
    

    
    var body: some View {
            
            NavigationView{
                List(filteredMemes, id: \.self){
                    
                    meme in
                    NavigationLink(destination: MemeEditorView(from: meme)) {
                        MemeView(meme: meme)
                    } 
                    
                    
                    
                    
                    
                }
                
                
                .navigationTitle("Popular Memes")
               
                
            }
            
            .searchable(text: $searchText)
            .onAppear{
                viewModel.fetchMemes()
            }
            
        

        
    }


}

struct MemeListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemeListView()
                

        }
    }

}



