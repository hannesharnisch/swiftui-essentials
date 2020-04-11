//
//  MusicControl.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 28.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import SwiftUI


struct MusicControlLarge: View {
    @Binding var nowPlaying:Song?
    @Binding var enabled:Bool
    @Binding var playing:Bool
    var onPlayPause:(Bool) -> ()
    var onBackward:() ->()
    var onForward:() -> ()
    
    init(playing:Binding<Bool>,nowPlaying:Binding<Song?>,enabled:Binding<Bool>,onPlayPause:@escaping(Bool) -> (),onForward:@escaping() -> (),onBackward:@escaping () -> ()){
        self._playing = playing
        self._nowPlaying = nowPlaying
        self._enabled = enabled
        self.onPlayPause = onPlayPause
        self.onBackward = onBackward
        self.onForward = onForward
    }
    var body: some View {
        Group{
            //MusikSlider(value:(CGFloat(state.nowPlaying?.bookmarkTime ?? 1) / CGFloat(state.nowPlaying?.playbackDuration ?? 1))).disabled(!self.state.isServer).padding(.horizontal)
            if (self.nowPlaying != nil){
                VStack(alignment:.leading){
                    Text(self.nowPlaying?.title ?? "").padding(.horizontal).padding(.top)
                    Text(self.nowPlaying?.interpret ?? "").padding(.horizontal).padding(.bottom).font(.caption)
                }
            }else{
                Text("Not Playing").padding()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    self.onBackward()
                }) {
                    Image(systemName: "backward.fill").resizable().scaledToFit().frame(width:40,height:40)
                }.padding().disabled(!enabled).foregroundColor(!enabled ? .gray : .primary)
                Spacer()
                Button(action: {
                    self.playing.toggle()
                    self.onPlayPause(self.playing)
                }) {
                    Image(systemName: (self.playing) ? "pause.fill":"play.fill").resizable().scaledToFit().frame(width:40,height:40).foregroundColor(!enabled ? .gray : .primary)
                }.padding().disabled(!enabled)
                Spacer()
                Button(action: {
                    self.onForward()
                }) {
                    Image(systemName: "forward.fill").resizable().scaledToFit().frame(width:40,height:40).foregroundColor(!enabled ? .gray : .primary)
                    }.padding().disabled(!enabled)
                Spacer()
            }
            Spacer()
        }
    }
}
struct MusicControlSmall: View{
    @Binding var nowPlaying:Song?
    @Binding var enabled:Bool
    @Binding var playing:Bool
    var onPlayPause:(Bool) -> ()
    var onForward:() -> ()
    
    init(playing:Binding<Bool>,nowPlaying:Binding<Song?>,enabled:Binding<Bool>,onPlayPause:@escaping(Bool) -> (),onForward:@escaping() -> ()){
        self._playing = playing
        self._nowPlaying = nowPlaying
        self._enabled = enabled
        self.onPlayPause = onPlayPause
        self.onForward = onForward
    }
    var body: some View {
        Group{
            if (self.nowPlaying != nil){
                    VStack(alignment:.leading){
                        Text(self.nowPlaying?.title ?? "").padding(.leading)
                        Text(self.nowPlaying?.interpret ?? "").padding(.leading).font(.caption)
                    }
                }else{
                    Text("Not Playing").padding(.leading)
                }
            Spacer()
                Button(action: {
                    self.playing.toggle()
                    self.onPlayPause(self.playing)
                }) {
                    Image(systemName: (self.playing ) ? "pause.fill":"play.fill").resizable().scaledToFit().frame(width:20,height:20).padding(.vertical).padding(.leading).foregroundColor(!enabled ? .gray : .primary)
                }.disabled(!enabled)
                Button(action: {
                    print("Action")
                    self.onForward()
                }) {
                    Image(systemName: "forward.fill").resizable().scaledToFit().frame(width:20,height:20).padding(.vertical).padding(.trailing).foregroundColor(!enabled ? .gray : .primary)
                }.disabled(!enabled)
        }
    }
}
