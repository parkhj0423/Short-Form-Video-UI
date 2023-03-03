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
    @Binding var currentVideo : String
    
    @State private var showMore : Bool = false
    
    @State private var isPaused : Bool = false
    @State private var pauseAnimation : Bool = false
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack(alignment : .bottom) {
            if let player = video.player {
                CustomPlayer(player: player)
                                
                videoInfoView()
            }
        }
        .overlay {
            CustomBottomSheet(showSheet: $showSheet) {
                CommentListView()
            }
        }
        .overlay {
            autoPlayCalculater()
        }
        .onTapGesture {
            onVideoTap()
        }
        .overlay {
            centerPlayAndPauseIcon()
        }
    }
    
    private func autoPlayCalculater() -> some View {
        GeometryReader { proxy -> Color in
            
            let minY = proxy.frame(in: .global).minY
            
            let size = proxy.size
            
            DispatchQueue.main.async {
                if -minY < (size.height / 2) && minY < (size.height / 2) && currentVideo == video.id && !isPaused {
                    video.player?.play()
                } else {
                    video.player?.pause()
                }
            }
            
            return Color.clear
        }
    }
    
    private func videoControlView() -> some View {
        Color.black
            .frame(width: 150, height: 150)
            .opacity(0.01)
            .onTapGesture {
                if pauseAnimation {
                    return
                }
                
                isPaused.toggle()
                withAnimation {
                    pauseAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation {
                        pauseAnimation.toggle()
                    }
                }
            }
    }
    
    
    @ViewBuilder
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
                    self.showSheet = true
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
    
    private func centerPlayAndPauseIcon() -> some View {
        Image(systemName: isPaused ? "pause.fill" : "play.fill")
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(.secondary)
            .clipShape(Circle())
            .foregroundStyle(.black)
            .opacity(pauseAnimation ? 1 : 0)
    }
    
    private func onVideoTap() {
        if pauseAnimation {
            return
        }
        
        if isPaused {
            video.player?.play()
        } else {
            video.player?.pause()
        }
        
        // Show Icon
        isPaused.toggle()
        withAnimation {
            pauseAnimation.toggle()
        }
        
        
        // Hide Icon after 0.8 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                pauseAnimation.toggle()
            }
        }
    }
    
    
}

struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let player = AVPlayer(url : URL(filePath: Bundle.main.path(forResource: "sun", ofType: "mp4") ?? ""))
        
        let mediaFile = MediaFile(url: "sun", title: "Sun", description: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.")
        
        VideoPlayer(video: .constant(Video(player : player, mediaFile: mediaFile)), currentVideo: .constant("sun"))
    }
}

