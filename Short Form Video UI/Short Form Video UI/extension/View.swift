//
//  View.swift
//  Short Form Video UI
//
//  Created by 박현우 on 2023/03/05.
//

import Foundation
import SwiftUI

extension View {
    func showBottomSheet<SubContent : View>(showSheet : Binding<Bool>, subContent : @escaping () -> SubContent) -> some View {
        self.modifier(CustomBottomSheetModifier(showSheet: showSheet, subContent: subContent))
    }
}
