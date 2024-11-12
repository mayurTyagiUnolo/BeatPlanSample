//
//  CustomBackButton.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 07/11/24.
//


import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        Button{
            dismiss()
        } label: {
            Image("new_back_icon")
        }
    }
}
