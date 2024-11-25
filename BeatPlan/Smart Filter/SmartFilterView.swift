//
//  SmartFilterView.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 25/11/24.
//

import SwiftUI

struct SmartFilterView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Apply Filters")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top)
            
            Spacer()
            
            Button{
                print("Hello")
            } label: {
                Text("Apply Filters")
            }
            .contentShape(Rectangle())
            .padding(50)
            .background(.yellow)
            .frame(maxWidth: .infinity)
            .background(.green)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.red)
    }
}

#Preview {
    SmartFilterView()
}


