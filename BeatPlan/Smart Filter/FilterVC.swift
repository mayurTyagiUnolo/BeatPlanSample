//
//  FilterVC.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 25/11/24.
//

import SwiftUI

struct FilterVC: View {
    @State private var showSheet: Bool = false
    var body: some View {
        VStack{
            Button("Open Sheet"){
                showSheet = true
            }
            .padding()
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
        }
        .sheet(isPresented: $showSheet) {
            SmartFilterView()
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    FilterVC()
}
