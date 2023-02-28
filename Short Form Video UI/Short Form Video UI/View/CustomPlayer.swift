//
//  CustomPlayer.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/28.
//

import SwiftUI
import AVKit

struct CustomPlayer: UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> some AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        
        controller.videoGravity = .resizeAspectFill
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
         
    }
}
