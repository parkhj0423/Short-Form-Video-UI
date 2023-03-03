//
//  CustomBottomSheet.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/03.
//

import SwiftUI

struct CustomBottomSheet<Content : View>: View {
    
    @Binding var showSheet : Bool
    var content : () -> Content
    
    @State private var bottomSheetHeight : CGFloat = 100
    @State private var offset : CGFloat = 0
    @State private var lastOffset : CGFloat = 0
    @GestureState private var gestureOffset : CGFloat = 0
    
    var body: some View {
        if showSheet {
            // DragGesture의 높이값 계산
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                
                return AnyView(
                    ZStack {
                        BlurView(style: .systemThickMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        
                        sheetIndicator()
                        
                        VStack(spacing : 0) {
                            headerView()
                            
                            ScrollView(showsIndicators: false) {
                                content()
                            }
                        }
                        
                    }
                        .offset(y : height - bottomSheetHeight)
                    // CustomBottomSheet의 하단 부분이 bounce 되지 않게 구현
                        .offset(y : -offset > 0 ? -offset <= (height - bottomSheetHeight) ? offset : -(height - bottomSheetHeight) : 0)
                        .gesture(
                            DragGesture()
                                .updating($gestureOffset) { value, out, _ in
                                    out = value.translation.height
                                    onGestureChanged()
                                }
                                .onEnded { value in
                                    
                                    let maxHeight = height - bottomSheetHeight
                                    
                                    withAnimation {
                                        // 전체 height의 2/3 높이 (maxHeight / 3) * 2
                                        if -offset > bottomSheetHeight && -offset < (maxHeight / 2) {
                                            // 중간 사이즈
                                            offset = -(maxHeight / 2)
                                        } else if -offset > (maxHeight / 2) {
                                            print("큰")
                                            // 큰 사이즈
                                            offset = -maxHeight + bottomSheetHeight
                                        } else {
                                            self.showSheet = false
                                        }
                                    }
                                    
                                    
                                    // 마지막 offset 저장
                                    lastOffset = offset
                                }
                        )
                )
            }
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            .animation(.easeInOut)
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
//    private func backgroundImageView() -> some View {
//        GeometryReader { proxy in
//            let frame = proxy.frame(in: .global)
//            
//            Image("JamesWeb")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: frame.width, height: frame.height, alignment: .center)
//        }
//        .blur(radius: getBlurRadius())
//        .ignoresSafeArea()
//    }
//    
    private func headerView() -> some View {
        VStack {
            HStack {
                Text("Comments")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    self.showSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
            }
            .padding([.horizontal, .top], 30)
            
            Rectangle()
                .fill(Color(uiColor: UIColor.darkGray))
                .frame(height : 1)
        }
    }
    
    private func sheetIndicator() -> some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: 60, height: 5)
                .padding(.top)
        }
        .frame(maxHeight : .infinity, alignment: .top)
    }
    
    private func onGestureChanged() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    private func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - bottomSheetHeight)
        return progress * 30
    }
}

struct CustomBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomSheet(showSheet: .constant(true)) {
            
            CommentListView()
            
        }
    }
}
