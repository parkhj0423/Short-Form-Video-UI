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
    
    @State private var offset : CGFloat = UIScreen.main.bounds.height / 2
    @State private var lastOffset : CGFloat = UIScreen.main.bounds.height / 2
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
                        .offset(y : offset)
                        .gesture(
                            DragGesture()
                                .updating($gestureOffset) { value, out, _ in
                                    out = value.translation.height
                                    onGestureChanged()
                                }
                                .onEnded { value in
                                    withAnimation {
                                        /// offset이 0 일 경우 최대 사이즈
                                        if lastOffset < offset && offset < (height / 2)  {
                                            // 중간 사이즈
                                            offset = (height / 2)
                                        } else if offset < (height / 2) {
                                            // 최대 사이즈
                                            // safeArea만큼의 offset
                                            offset = getSafeAreaTop()
                                        } else if offset > (height / 2) {
                                            // 중간 사이즈 보다 offset이 클 경우 sheet을 내림
                                            resetOnDismiss()
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
            if gestureOffset + lastOffset < 0 {
                return
            }
            self.offset = gestureOffset + lastOffset
        }
    }
    
    private func resetOnDismiss() {
        DispatchQueue.main.async {
            withAnimation {
                self.offset = UIScreen.main.bounds.height / 2
                self.lastOffset = UIScreen.main.bounds.height / 2
            }
        }
    }
    
    func getSafeAreaTop() -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets.top ?? 0
    }

}

struct CustomBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomSheet(showSheet: .constant(true)) {
            
            CommentListView()
            
        }
    }
}
