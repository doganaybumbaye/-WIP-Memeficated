//
//  FreeEditorView.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 3.11.2021.
//

import SwiftUI

struct FreeEditorView: View {
    var meme : Meme.Info
    @State var showSheet = false
    @State var image = UIImage()
    @State var newImage = UIImage()
    @State var ingredientNames = ["Make your own meme"]
    @State private var navBarHeight: CGFloat = 0.0
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(from meme : Meme.Info){
        self.meme = meme
        

    }
    var body: some View {
        
        
        NavigationView{
            
        
        VStack(spacing: 8){
            generatedImage
            


            
            ScrollView{
                

           
            VStack{
                ForEach(ingredientNames.indices, id : \.self){
                    index in
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
                    }

                    Spacer()
                }.padding(.leading)
                


            }
                
            }
            .navigationBarTitle("Custom Meme", displayMode: .inline)
            .background(NavBarAccessor {
                navbar in
                self.navBarHeight = navbar.bounds.height
            })
        }
        
        
        
        
        .navigationBarItems(
            
            leading:
                
                
                Button {
                    showSheet = true

                } label: {
                    Image("uploadimage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(5)

                    
                }
                .sheet(isPresented : $showSheet){
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                
                
                
                


                
                                
    ,trailing:
                Button {
        self.saveImage()
        guard Image(uiImage: newImage) != nil else {
            return
        }
            
            
        let activityController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)

                UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    } label: {
        Image("saveandshare")
            
            .resizable()
            
            .frame(width: 30, height: 30)
            .padding(5)

            
    }
)
        
            }
        
        }
    
    

    var generatedImage : some View {

        ZStack{
            DraggbleImage(image: image)
            

                
            ForEach(ingredientNames, id : \.self){
                newLabel in
                DraggbleText(text: newLabel)
            }
            }
        
        .clipped()
        
        
       
    }
    
    func saveImage() -> UIImage{
        newImage = generatedImage.takeScreenshot(origin: CGPoint(x: 0, y: UIApplication.shared.windows[0].safeAreaInsets.top + navBarHeight + 1), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)) ?? UIImage()

            
    
        return newImage
    }
    
    

}



struct FreeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        FreeEditorView(from: .fakeMeme)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
