//
//  PulsingCircle.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 28.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import SwiftUI

struct PulsingCircle: View {
    @State var pulsingCircle = false
    var startSize:CGFloat
    var scaleing:CGFloat
    var duration:Double = 3
    var timediff:Double = 0
    @State var color:Color
    var body: some View {
        Circle().stroke(color,lineWidth: 0.1).foregroundColor(.white).frame(width: startSize, height: startSize, alignment: .center).scaleEffect(self.pulsingCircle ? scaleing : 1 ).opacity(self.pulsingCircle ? 0 : 1).animation(Animation.easeInOut(duration: duration).repeatForever(autoreverses:false).speed(1)).onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.timediff) {
                self.pulsingCircle = true
            }
        }
    }
}
