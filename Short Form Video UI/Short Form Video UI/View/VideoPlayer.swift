//
//  VideoView.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/28.
//

import SwiftUI
import AVFoundation

struct VideoPlayer: View {
    
    @Binding var video : Video
    
    @State private var showMore : Bool = false
    
    var body: some View {
        ZStack(alignment : .bottom) {
            if let player = video.player {
                CustomPlayer(player: player)
                
                videoInfoView()
            }
        }
        .onAppear {
            video.player?.play()
        }
        .onDisappear {
            video.player?.pause()
        }
    }
    
    
    private func videoInfoView() -> some View {
        VStack {
            
            HStack {
                descriptionView()
                
                Spacer(minLength: 70)
                
                trailingButtonView()
            }
            
        }
        .font(.system(size: 23, weight: .bold))
        .foregroundColor(Color.white)
        .padding(.horizontal)
        .padding(.bottom, 40)
        .frame(maxHeight : .infinity, alignment: .bottom)
    }
    
    private func descriptionView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Spacer()
            
            userInfoView()
            
            Text(video.mediaFile.title)
            
            HStack {
                Text(video.mediaFile.description)
                    .font(.system(size: 15))
                    .lineLimit(showMore ? nil : 1)
                
                
                showMoreButton()
            }
        }
    }
    
    @ViewBuilder
    private func showMoreButton() -> some View {
        if !showMore {
            Button {
                self.showMore = true
            } label: {
                Text("showMore")
                    .font(.system(size: 15))
                    .foregroundColor(Color(uiColor: UIColor.lightGray))
            }
        }
    }
    
    private func userInfoView() -> some View {
        HStack {
            Circle()
                .frame(width: 30, height: 30)
            
            Text("@parkhj0423")
                .font(.callout)
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .frame(width : 40, height: 30)
                    .overlay {
                        Text("구독")
                            .font(.caption2)
                            .fontWeight(.bold)
                    }
            }
        }
    }
    
    private func trailingButtonView() -> some View {
        VStack(spacing : 30) {
            Spacer()
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                Text("92")
            }
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "hand.thumbsdown.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("2")
            }
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "text.bubble.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("523")
            }
            
            Button {
                
            } label: {
                Image(systemName: "arrowshape.turn.up.forward.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
        }
        .font(.caption2)
    }
}

struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let player = AVPlayer(url : URL(filePath: Bundle.main.path(forResource: "sun", ofType: "mp4") ?? ""))
        
        let mediaFile = MediaFile(url: "sun", title: "Sun", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.")
        
        VideoPlayer(video: .constant(Video(player : player, mediaFile: mediaFile)))
    }
}

