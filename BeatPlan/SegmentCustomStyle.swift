//
//  SegmentCustomStyle.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 18/10/24.
//
import SwiftUI

struct SegmentCustomStyle: View {
    @Binding var selection: Int
    let options: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                VStack(spacing: 4) {
                    Text(options[index])
                        .foregroundColor(selection == index ? .blue : .gray)
                        .fontWeight(selection == index ? .medium : .regular)
                        .disableAnimations()
                        .onTapGesture {
                            withAnimation { // Trigger animation for color and rectangle
                                selection = index
                            }
                        }
                    
                    Rectangle()
                        .fill(selection == index ? .blue : .clear) // Animate the rectangle fill color
                        .frame(height: 2)
                        .animation(.easeInOut, value: selection) // Animate the color transition
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
