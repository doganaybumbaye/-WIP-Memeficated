//
//  TabBarView.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 2.11.2021.
//

import SwiftUI

struct TabBarView: View {
    @State var showPopUp = false
    @ObservedObject var viewRouter: ViewRouter
     
        
        var body: some View {
             GeometryReader { geometry in
                 VStack {
                     Spacer()
                     switch viewRouter.currentPage {
                     case .homepage:
                         MemeListView()
                         
                     case .like:
                         MemeEditorView(from: .fakeMeme)

                     case .records:
                        Text("Records")
                     case .user:
                         Text("User")

                     case .plus:
                         Text("User")
                     }
                     Spacer()
                     ZStack {

                         HStack {
                             TabBarIcon(viewRouter: viewRouter, assignedPage: .homepage, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit")
                             TabBarIcon(viewRouter: viewRouter, assignedPage: .like, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "heart")
                             ZStack {
                                 Circle()
                                     .foregroundColor(.white)
                                     .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                     .shadow(radius: 4)
                                 Image(systemName: "plus.circle.fill")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                     .foregroundColor(Color("Darkpurple"))
                                     .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                             }
                                 .offset(y: -geometry.size.height/8/2)
                                 .onTapGesture {
                                     withAnimation {
                                         viewRouter.currentPage = .plus
                                         showPopUp.toggle()
                                     }
                                         
                                     
                                 }
                             TabBarIcon(viewRouter: viewRouter, assignedPage: .records, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "waveform")
                             TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle")
                         }
                             .frame(width: geometry.size.width, height: geometry.size.height/8)
                         .background(Color("TabBarBackground").shadow(radius: 2))
                     }
                 }
                     .edgesIgnoringSafeArea(.bottom)
             }
         }
     }



struct TabBarIcon : View{
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName: String
    

    var body: some View{


        VStack{
           Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)

                Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
                     viewRouter.currentPage = assignedPage
                 }
                 .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
    }
}




struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewRouter: ViewRouter())
            .previewDevice("iPhone 13 Pro")
            .preferredColorScheme(.dark)
    }
}


class ViewRouter : ObservableObject{
    @Published var currentPage : Page = .homepage
}

enum Page{
    case homepage
    case like
    case records
    case user
    case plus
    
}

