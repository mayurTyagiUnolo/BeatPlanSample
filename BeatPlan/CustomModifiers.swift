//
//  CustomModifiers.swift
//  senseStaff
//
//  Created by Mayur on 02/10/24.
//  Copyright © 2024 SmartSense. All rights reserved.
//

import SwiftUI

struct MainTextFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.black.opacity(0.9))
            .fontWeight(.medium)
    }
}

struct SubTextFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundStyle(.secondary)
            .fontWeight(.regular)
    }
}

struct DisableAnimationsViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.transaction { $0.animation = nil }
    }
}
