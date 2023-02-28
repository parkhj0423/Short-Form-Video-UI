//
//  VideoView.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/28.
//

import SwiftUI

struct VideoPlayer: View {
    
    @Binding var video : Video
    
    var body: some View {
        ZStack {
            if let player = video.player {
                CustomPlayer(player: player)
                
                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment : .leading, spacing: 10) {
                            HStack(spacing : 15) {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                
                                Text("Name")
                            }
                        }
                    }
                }
                .frame(maxHeight : .infinity, alignment: .bottom)
            }
        }
    }
}

