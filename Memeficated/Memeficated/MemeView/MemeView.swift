//
//  MemeView.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 25.10.2021.
//

import SwiftUI

struct MemeView: View {
    let meme : Meme.Info
    var body: some View {
        
        AsyncImage(url: URL(string: meme.url ?? "https://i.imgflip.com/319g4i.png")!){
            RoundedRectangle(cornerRadius: 0)
        }
            .aspectRatio(contentMode: .fill)
            .frame(width : UIScreen.main.bounds.width - 50, height: 350)
            .overlay(
                Text(meme.name ?? "")
                    
                    .bold()
                    .font(.system(size: 27, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.75), Color.clear]), startPoint: .bottom, endPoint: .top)),
                alignment: .bottom
            )
            .cornerRadius(20)
            .padding(.vertical)
    }
}

struct MemeView_Previews: PreviewProvider {
    static var previews: some View {
        MemeView(meme : .fakeMeme)
            .previewDevice("iPhone 12 Pro")
            
        
    }
}
