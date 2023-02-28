//
//  Video.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/28.
//

import Foundation
import AVKit

struct Video : Identifiable {
    var id = UUID().uuidString
    var player : AVPlayer?
    var mediaFile : MediaFile
}
