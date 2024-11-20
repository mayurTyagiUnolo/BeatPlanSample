//
//  CustomAlertController.swift
//  BeatPlan
//
//  Created by Mayur Kant Tyagi on 15/11/24.
//

import SwiftUI

struct CustomAlertController: View {
    @State private var showOptionAlert: Bool = false
    @State private var showReasonAlert: Bool = false
    
    var body: some View{
        ZStack{
            VStack(spacing: 50){
                
                Spacer()
                
                Button("optionAlert"){
                    withAnimation{
                        showOptionAlert = true
                    }
                }
                .frame(width: 100, height: 40)
                .padding()
                .background(.green)
                .clipShape(.capsule)
                
                Button("reasonAlert"){
                    withAnimation{
                        showReasonAlert = true
                    }
                }
                .frame(width: 100, height: 40)
                .padding()
                .background(.red)
                .clipShape(.capsule)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            
            if showOptionAlert{
                CustomAlertOfOptions(optionOne: "Choose for one day", optionSecond: "Choose for multiple days", completionHander: {i in }, showAlert: $showOptionAlert)
            }
            
//            if showReasonAlert{
////                CustomAlertOfTextView(showAlert: $showReasonAlert)
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.2))
    }
}

#Preview {
    CustomAlertController()
}
