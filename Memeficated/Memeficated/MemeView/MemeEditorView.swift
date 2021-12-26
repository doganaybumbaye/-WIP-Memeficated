//
//  MemeEditorView.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 28.10.2021.
//

import SwiftUI
import Kingfisher



struct MemeEditorView: View {
    let meme: Meme.Info
    @State var ingredientNames = [""]
    @State var createDone = false
    @State private var addedLabels: [String]
    @State var newImage = UIImage()
    
    @State private var navBarHeight: CGFloat = 0.0
    
    @Environment(\.presentationMode) private var presentationMode

    init(from meme: Meme.Info) {
        self.meme = meme
        self._addedLabels = State(initialValue: Array.init(repeating: "", count: meme.boxCount ?? 0))
    }

    var body: some View {
        VStack(spacing: 8) {
            memeImageView

            ScrollView{
                
            
            ForEach(0..<(meme.boxCount ?? 0)) { i in
                TextField("Label \(i + 1)", text: $addedLabels[i])
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(10)
                


            }.padding(.horizontal)
            ForEach(ingredientNames.indices, id : \.self){ index in
                
                TextField("New Label", text: $ingredientNames[index])
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(10)
            }
                HStack{
                    Button {
                        ingredientNames.append("")
                    } label: {
                      
                        Image("addtext")
                            .resizable()
                            
                            .frame(width: 20, height: 20)
                            

                        Text("Add Text")
                            .foregroundColor(Color("Darkpurple"))
                        Spacer()
                    }
                }.padding(.leading)
            Spacer()
        }
        }
        .navigationBarTitle(meme.name ?? "Meme", displayMode: .inline)
        .background(NavBarAccessor {
            navbar in
            self.navBarHeight = navbar.bounds.height
        })
        //.navigationBarBackButtonHidden(true)
        
        .navigationBarItems(trailing:
            Button(action: {
            self.saveImage()
            guard Image(uiImage: newImage) != nil else {
                return
            }
                
                
            let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)

                    UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
        }, label: {
            Image("saveandshare")
                .resizable()
                
                .frame(width: 30, height: 30)
                .padding(5)
        })
        )
            
     
    }
    
    var memeImageView : some View{
        ZStack {
            KFImage(URL(string: meme.url!)!).placeholder{
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIScreen.main.bounds.height / 2.5)
            

            .padding(.horizontal)

            ForEach(addedLabels, id: \.self) { label in
                DraggbleText(text: label)
            }
            ForEach(ingredientNames, id : \.self){
                newLabel in
                DraggbleText(text: newLabel)
            }
            
        }.clipped()
    }
    
    
    func saveImage() -> UIImage{
        newImage = memeImageView.takeScreenshot(origin: CGPoint(x: 0, y: UIApplication.shared.windows[0].safeAreaInsets.top + navBarHeight + 1), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)) ?? UIImage()

            
    
        return newImage
    }
}
    



struct MemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MemeEditorView(from: .fakeMeme)
            
    }
}


