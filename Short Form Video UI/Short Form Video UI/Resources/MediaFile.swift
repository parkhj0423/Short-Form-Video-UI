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
    var description : String
    var isExpanded : Bool = false
}

var MediaFileJSON = [
    MediaFile(url: "laser", title: "Laser", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "firework", title: "Firework", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "galaxy", title: "Galaxy", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "planets", title: "Planets", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "star-field", title: "Star-Field", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "stars", title: "Stars", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "cave", title: "Cave", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "universe", title: "Universe", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "galaxy2", title: "Galaxy", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
    
    MediaFile(url: "plasma-ball", title: "Plasma", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
]
