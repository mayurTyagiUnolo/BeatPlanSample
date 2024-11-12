//
//  View_Extension.swift
//  senseStaff
//
//  Created by Mayur on 02/10/24.
//  Copyright © 2024 SmartSense. All rights reserved.
//

import SwiftUI

extension View {
    func mainTextFont() -> some View{
        modifier(MainTextFont())
    }
    
    func subTextFont() -> some View{
        modifier(SubTextFont())
    }
    
    func disableAnimations() -> some View {
        modifier(DisableAnimationsViewModifier())
    }
    
}
