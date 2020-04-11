//
//  ZStackModifier.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 28.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import Foundation
import SwiftUI

struct ZStackModifier:ViewModifier{
    var toggle1:Bool
    var toggle2:Bool
    var variableTopPadding:CGFloat
    var variableBottomPadding:CGFloat
    func body(content: Content) -> some View {
        content.shadow(radius: 40).padding(.top, ((self.toggle1) ? 0 : variableTopPadding)).padding(.bottom, (self.toggle2) ? 0 : variableBottomPadding)
    }
}
