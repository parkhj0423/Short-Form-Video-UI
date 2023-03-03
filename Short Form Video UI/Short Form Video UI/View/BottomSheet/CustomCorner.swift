//
//  CustomCorner.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/04.
//

import SwiftUI

struct CustomCorner: Shape {
    var corners : UIRectCorner
    var radius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
