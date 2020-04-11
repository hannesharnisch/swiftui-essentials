//
//  Song.swift
//  PartyCollaborate2
//
//  Created by Hannes Harnisch on 30.03.20.
//  Copyright © 2020 Hannes Harnisch. All rights reserved.
//

import Foundation
import MediaPlayer


struct Song:Codable,Equatable{
    var id = UUID()
    var title:String
    var interpret:String
    var appleMusicURL:URL?
    var spotifyURL:URL?
    var image:Data?
    
    func getImage() ->UIImage?{
        if image != nil{
            return UIImage(data: image!, scale: 1.0)
        }else{
            return nil
        }
    }
    init?(song:MPMediaItem){
        self.title = song.title ?? ""
        self.interpret = song.albumArtist ?? ""
        self.appleMusicURL = song.assetURL ?? URL(string: "")
        self.image = song.artwork?.image(at: CGSize(width: 150, height: 150))?.pngData()
        if title == ""{
            print("NO TITLE")
            return nil
        }
    }
    init(title:String,interpret:String){
        self.title = title
        self.interpret = interpret
    }
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.interpret == rhs.interpret
    }
    func toMPMediaItem()->[MPMediaItem]?{
        let SongUrl = (appleMusicURL?.absoluteString ?? "") as NSString
        print("songURL: \(SongUrl)")
        if SongUrl != ""{
        let number = SongUrl.substring(from: 32);
         print("my song number "+number);
        let query = MPMediaQuery.songs();
        let urlQuery = MPMediaPropertyPredicate(value:number,forProperty: MPMediaItemPropertyPersistentID,comparisonType: .contains);
         query.addFilterPredicate(urlQuery);
         let mediaItem = query.items! as [MPMediaItem];
            return mediaItem
        }else{
            return nil
        }
    }
}
