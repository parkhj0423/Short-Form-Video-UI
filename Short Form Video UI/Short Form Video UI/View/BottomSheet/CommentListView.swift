//
//  CommentListView.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/04.
//

import SwiftUI

struct CommentListView: View {
    var body: some View {
        VStack(alignment : .leading, spacing: 10) {
            ForEach(0..<20) { _ in
                CommtentRowView()
            }
        }
        
        .frame(maxWidth: .infinity)
        
    }
}

struct CommtentRowView : View {
    var body: some View {
        VStack {
            HStack(alignment : .top, spacing: 20) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 50, height: 50)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing : 2) {
                        Text("parkhj0423")
                        Text("﹒")
                        Text("1시간 전")
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(uiColor: UIColor.darkGray))
                    
                    Text("Great!!")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color.white)
                    
                    
                    HStack(spacing : 50) {
                        Button {
                            
                        } label: {
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "hand.thumbsdown")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "text.bubble")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 10)
                    
                }
                
                
                Spacer()
            }
            .padding()
            
            
            Rectangle()
                .fill(Color(uiColor: UIColor.darkGray))
                .frame(height : 1)
        }
       
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView()
    }
}
