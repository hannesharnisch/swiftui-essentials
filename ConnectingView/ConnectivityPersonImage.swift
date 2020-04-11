//
//  ConnectivityPersonImage.swift
//  PartyCollaborate
//
//  Created by Hannes Harnisch on 10.04.20.
//  Copyright © 2020 hannes.harnisch. All rights reserved.
//

import SwiftUI

struct ConnectivityPersonImage<Content:View>: View {
    let content:Content
    var width:CGFloat = 50
    var height:CGFloat = 50
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
            Image(systemName: "person.crop.circle").resizable().frame(width: width, height: height, alignment: .center).foregroundColor(color)
            VStack{
                Text(name).foregroundColor(.primary)
                content
            }
        }
    }
}
