//
//  RoundedTextFieldStyle.swift
//  BherubabaSample
//
//  Created by Mayur Tyagi on 27/09/24.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    var text: String
    var showSearchIcon = true
    var innerBackgroundColor: SwiftUI.Color = .clear
    var showBorder: Bool = true
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                ZStack(alignment: .trailing){
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .stroke(showBorder ? SwiftUI.Color.gray.opacity(0.2) : .clear, lineWidth: 1)
                    if showSearchIcon && text.isEmpty{
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .padding(10)
                    }
                    
                }
            )
            .background(
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(innerBackgroundColor)
            )
            .padding(.vertical, 5)
    }
}
