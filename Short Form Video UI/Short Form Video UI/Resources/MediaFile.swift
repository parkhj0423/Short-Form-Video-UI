//
//  MediaFile.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/26.
//

import SwiftUI

struct MediaFile : Identifiable {
    var id = UUID().uuidString
    var url : String
    var title : String
    var isExpanded : Bool = false
}

var MediaFileJSON = [
    MediaFile(url: "aurora", title: "Aurora"),
    MediaFile(url: "bullfinch", title: "Bullfinch"),
    MediaFile(url: "cat", title: "Cat"),
    MediaFile(url: "earth", title: "Earth"),
    MediaFile(url: "flamingo", title: "Flamingo"),
    MediaFile(url: "jellyfish", title: "JellyFish"),
    MediaFile(url: "lights", title: "Lights"),
    MediaFile(url: "lotus", title: "Lotus"),
    MediaFile(url: "love", title: "Love"),
    MediaFile(url: "mountain", title: "mountain"),
    MediaFile(url: "surf", title: "Surf"),
    MediaFile(url: "wormhole", title: "Wormhole")
    
]
