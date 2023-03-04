//
//  UIApplication.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/05.
//

import Foundation
import UIKit

extension UIApplication {
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
