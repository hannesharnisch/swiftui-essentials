//
//  ConnectingView.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 22.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct ConnectingView<T:ConnectivityEnabled>: View {
    @Binding var discoveredPeers:[String]
    @Binding var connectedPeers:[String]
    @Binding var isServer:Bool
    var connectivity:T?
    var height:CGFloat
    var body: some View {
        VStack(alignment:.center){
            ActionToggle(isOn: $isServer,action: { toggled in
                self.connectivity?.switchedServerStatus(isServer: toggled)
            }){
                HStack{
                    Text("Hosting")
                    Image(systemName: "antenna.radiowaves.left.and.right").foregroundColor(self.connectedPeers.count != 0 ?  .green : .gray)
                }
            }.padding(.bottom,60)
            ScrollView(.horizontal,showsIndicators:false){
            HStack(alignment: .center){
                if self.discoveredPeers.count != 0{
                VStack{
                    Image(systemName: "chevron.right.square.fill").resizable().frame(width: 30, height: 30)
                    if self.isServer{
                        Text("Invitations").font(.caption)
                    }else{
                        Text("Discovered").font(.caption)
                    }
                }
                }
                if !isServer{
                    ForEach(self.discoveredPeers, id:\.self){ peer in
                            Button(action:{
                                self.connectivity?.connectTo(peer: peer)
                            }){
                                ConnectivityPhoneImage(name:peer){
                                        Image(systemName: "checkmark.circle").foregroundColor(.green)
                                }
                            }.disabled(self.connectedPeers.count != 0)
                    }
                }else{
                    ForEach(self.discoveredPeers, id:\.self){ peer in
                        ConnectivityPhoneImage(name: peer){
                                HStack{
                                    Button(action:{
                                         self.connectivity?.connection(accept: true, peer: peer)
                                    }){
                                        Image(systemName: "checkmark.circle").foregroundColor(.green)
                                    }
                                    Button(action:{
                                        self.connectivity?.connection(accept: false, peer: peer)
                                    }){
                                        Image(systemName: "xmark.circle").foregroundColor(.red)
                                    }
                                }
                            }
                    }
                }
                }.padding(.bottom).padding(.top)
            }
            ZStack{
                PulsingCircle(startSize: 10, scaleing: 60,color:.gray)
                PulsingCircle(startSize: 10, scaleing: 60, timediff: 0.8,color: .gray)
                VStack{
                    ConnectivityPhoneImage(name: UIDevice.current.name){
                        if !isServer && self.connectedPeers.count != 0{
                            Button(action:{
                                self.connectivity?.reset()
                            }){
                                Image(systemName: "xmark.circle").foregroundColor(.red)
                            }
                        }
                    }
                }
            }.modifier(ZStackModifier(toggle1: self.discoveredPeers != [], toggle2: self.connectedPeers != [],variableTopPadding: 140,variableBottomPadding: 145))
            ScrollView(.horizontal, showsIndicators:false){
            HStack(alignment: .center){
                if self.connectedPeers.count != 0{
                    VStack{
                        Image(systemName: "chevron.right.square.fill").resizable().frame(width: 30, height: 30)
                        Text("Connected").font(.caption)
                    }
                }
                ForEach(self.connectedPeers, id:\.self){ peerName in
                    ConnectivityPhoneImage(name: peerName){
                                if self.isServer{
                                    Button(action: {
                                        self.connectivity?.disconnectPeer(peer: peerName)
                                    }) {
                                        Image(systemName: "xmark.circle").foregroundColor(.red)
                                    }
                                }
                    }
                }
            }.padding(.bottom)
            }
            }.padding(.horizontal).frame(width:UIScreen.main.bounds.width)
    }
}

protocol ConnectivityEnabled {
    func switchedServerStatus(isServer:Bool)
    func connectTo(peer:String)
    func connection(accept:Bool,peer:String)
    func reset()
    func disconnectPeer(peer:String)
}
