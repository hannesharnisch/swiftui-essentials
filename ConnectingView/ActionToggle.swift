//
//  ActionToggle.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 28.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import SwiftUI

struct ActionToggle<Content:View>: View {
    var content:Content
    var action:(Bool)->(Void)
    @Binding var isOn:Bool
    
    init(isOn:Binding<Bool>,action:@escaping (Bool)->(Void),content:() -> Content){
        self._isOn = isOn
        self.content = content()
        self.action = action
    }
    var body: some View {
        Toggle(isOn: $isOn){
            if isOn{
                content.onAppear {
                    self.action(self.isOn)
                }
            }else{
                content.onAppear {
                    self.action(self.isOn)
                }
            }
        }
        
    }
}
