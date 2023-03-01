//
//  ShortFormVideoView.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/26.
//

import SwiftUI
import AVFoundation

struct ShortFormVideoView: View {
    
    @State var currentVideo = ""
    
    @State var videos = MediaFileJSON.map { item -> Video in
        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
        
        let player = AVPlayer(url : URL(filePath: url))
        
        return Video(player: player, mediaFile: item)
    }
    
    var body: some View {
        VStack(spacing : 0) {
            GeometryReader { proxy in
                let size = proxy.size
                TabView(selection: $currentVideo) {
                    ForEach($videos) { $video in
                        VideoPlayer(video: $video, currentVideo: $currentVideo)
                            .frame(width : size.width)
                            .rotationEffect(.init(degrees: -90))
                            .ignoresSafeArea(.all)
                            .tag(video.id)
                    }
                }
                .rotationEffect(.init(degrees: 90))
                .frame(width : size.height)
                .frame(width : size.width)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(.all)
            .background(Color.black.ignoresSafeArea())
            .onAppear {
                currentVideo = videos.first?.id ?? ""
            }
        }
    }
}

struct ShortFormVideoView_Previews: PreviewProvider {
    static var previews: some View {
        ShortFormVideoView()
    }
}
