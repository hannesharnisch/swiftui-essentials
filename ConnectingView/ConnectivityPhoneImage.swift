//
//  ConnectivityPhoneImage.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 28.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import SwiftUI

struct ConnectivityPhoneImage<Content:View>: View {
    let content:Content
    var width:CGFloat = 70
    var height:CGFloat = 80
    @Binding var color:Color
    let name:String
    init(name:String,@ViewBuilder content: () -> Content){
        self.content = content()
        self.name = name
        self._color = Binding(get: {
            return .gray
        }, set: { (color) in
        })
    }
    init(name:String,color:Binding<Color>,@ViewBuilder content: () -> Content){
        self.content = content()
        self.name = name
        self._color = color
    }
    var body: some View {
        VStack{
            Image("mobile").resizable().frame(width: width, height: height, alignment: .center).foregroundColor(color)
            VStack{
                Text(name).foregroundColor(.primary).multilineTextAlignment(.center).allowsTightening(true)
                content
            }.fixedSize()
        }
    }
}
