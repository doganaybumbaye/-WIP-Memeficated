//
//  TabbarCustomize.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 6.11.2021.
//

import SwiftUI

struct TabbarCustomize: View {
    @State var selectedIndex = 0
    var icons = ["homekit",
    "gear",
    "plus.circle",
 
    "lasso",
    "message"]
    @State var showSheet = false
    @State var fimage = UIImage()
    @State var isSelected = false
    

    
    var body: some View {
        
        VStack{
            ZStack{
                switch selectedIndex{
                case 0:
                    
                        
                            MemeListView()
                        
                        
                    
                case 1:
                    NavigationView{
                        VStack{
                            Text("4")
                        }
                        .navigationTitle("Home")
                    }
                    
                case 2:
                    FreeEditorView(from: .fakeMeme)
                case 3:
                    NavigationView{
                        VStack{
                            Text("4")
                        }
                        .navigationTitle("Home")
                    }
                case 4:
                    FreeEditorView(from: .fakeMeme)
                 
                case 5:
                    NavigationView{
                        VStack{
                            Text("6")
                        }
                        .navigationTitle("Home")
                    }
                default:
                    NavigationView{
                        VStack{
                            Text("Second Page")
                        }.navigationTitle("Home")
                    }
                }
            }
            
            Divider()
            HStack{
                ForEach(0..<5, id: \.self){ number in
                    Spacer()
                    Button {
                        self.selectedIndex = number
                        
                        if number == 2{
                            showSheet = true
                            
                            
                        }
                        
                    } label: {
                        if number == 2 {
                            
                           
                                
                        Image(systemName: icons[number])
   
                                .font(.system(size: 35, weight: .regular, design: .default))
                                .padding(5)
                                
                                .foregroundColor(selectedIndex == number ? Color("TabBarBackground") : Color("TabBarHighlight"))
                                .background(Color("Darkpurple"))
                                .cornerRadius(20)
                                
                            
                             
                            
                                
                                
                                
                           
                                
                                
                            
                            
                        }
                        else{
                            Image(systemName: self.icons[number])
                                .font(.system(size: 25, weight: .regular, design: .default))
                                .foregroundColor(selectedIndex == number ? Color("Darkpurple") : Color("TabBarHighlight"))
                            
                        }
                    }
                    Spacer()
                    
                }
            }
            
            Spacer()
            
        }.ignoresSafeArea(.keyboard)
            
        

    }
    
    

}

struct TabbarCustomize_Previews: PreviewProvider {
    static var previews: some View {
        TabbarCustomize()
            .preferredColorScheme(.dark)
    }
}


