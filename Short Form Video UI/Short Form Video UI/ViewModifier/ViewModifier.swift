//
//  ViewModifier.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/05.
//

import Foundation
import SwiftUI

struct CustomBottomSheetModifier<SubContent : View>: ViewModifier {
    
    @Binding var showSheet : Bool
    var subContent : () -> SubContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: showSheet ? getBlurRadius() : 0)
        }
        .overlay {
            CustomBottomSheet(showSheet: $showSheet) {
                subContent()
            }
        }  
    }
    
    private func getBlurRadius() -> CGFloat {
        return UIScreen.main.bounds.height * 0.01
    }
}
