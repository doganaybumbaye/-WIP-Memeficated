//
//  DraggbleImage.swift
//  Memeficated
//
//  Created by Doğanay Şahin on 4.11.2021.
//

import SwiftUI

struct DraggbleImage: View {
    @State private var currentPosition : CGSize = .zero
    @State private var newPosition : CGSize = .zero

    @State private var rotation : Double = 0.0
    @State private var scale : Double = 1.0
    @State private var labelColor : Color = .black
    
    private enum WidthState : Int{
        case full, half, third, fourth
    }
    
    @State private var widthState: WidthState = .full
    @State private var currentWidth: CGFloat = UIScreen.main.bounds.width
    var image : UIImage
    var body: some View {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .padding(.horizontal)
                   
                    
                    
                    
            }
            
            .scaleEffect(scale)
            .rotationEffect(Angle.degrees(rotation))
            .offset(x: self.currentPosition.width,
                    y: self.currentPosition.height)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.rotation = angle.degrees
                    }
                    .simultaneously(with:
                                        MagnificationGesture()
                                            .onChanged { scale in
                                                self.scale = scale.magnitude
                                            })
                    .simultaneously(with: DragGesture()
                                        .onChanged { value in
                                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                                                          height: value.translation.height + self.newPosition.height)
                                        }
                                        .onEnded { value in
                                            self.newPosition = self.currentPosition
                                        })
            )
            .onTapGesture(count: 2) {
                self.widthState = WidthState(rawValue: self.widthState.rawValue + 1) ?? .full
                self.currentWidth = UIScreen.main.bounds.width / CGFloat(self.widthState.rawValue)
            }
            .onTapGesture(count: 1) {
                self.labelColor = self.labelColor == .black ? .white : .black
            }
    }
}



struct DraggbleImage_Previews: PreviewProvider {
    static var previews: some View {
        DraggbleImage(image: UIImage())
    }
}
