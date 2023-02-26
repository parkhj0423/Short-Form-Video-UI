//
//  ShortFormVideoView.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/02/26.
//

import SwiftUI

struct ShortFormVideoView: View {
    
    @State var currentVideo = ""
    
    var body: some View {
        VStack(spacing : 0) {
            GeometryReader { proxy in
                let size = proxy.size
                TabView(selection: $currentVideo) {
                    ForEach(MediaFileJSON) { media in
                        VStack {
                            Text(media.title)
                            
                            Spacer()
                            
                            Text("Hi")
                                .frame(maxWidth : .infinity, alignment: .leading)
                        }
                        .frame(width : size.width)
                        .padding()
                        .rotationEffect(.init(degrees: -90))
                    }
                }
                .rotationEffect(.init(degrees: 90))
                .frame(width : size.height)
                .frame(width : size.width)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}

struct ShortFormVideoView_Previews: PreviewProvider {
    static var previews: some View {
        ShortFormVideoView()
    }
}
