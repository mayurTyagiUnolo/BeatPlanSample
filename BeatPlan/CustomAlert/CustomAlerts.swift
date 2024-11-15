//
//  CustomAlerts.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 15/11/24.
//


import SwiftUI

struct CustomAlertOfOptions: View {
    var optionOne: String
    var optionSecond: String
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 30){
                Button{
                    
                } label: {
                    HStack{
                        Image(systemName: "circle")
                        Text(optionOne)
                    }
                }
                
                Button{
                    
                } label: {
                    HStack{
                        Image(systemName: "circle")
                        Text(optionSecond)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
            
            HStack{
                Spacer()
                
                Button("cancel"){
                    showAlert = false
                }
                .padding()
                
                Button("Apply"){
                    showAlert = false
                }
                
            }
            .padding(.trailing, 30)
            .padding(.bottom, 20)

        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .padding(.horizontal, 40)
    }
}


struct CustomAlertOfTextView: View {
    @State private var text: String = ""
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Remarks")
                .padding()
            
            TextField("Comment", text: $text, prompt: Text("Please input your comment"), axis: .vertical)
                .lineLimit(6...6)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(SwiftUI.Color.gray.opacity(0.5), lineWidth: 0.5)
                }
                .foregroundStyle(.secondary)
                .background(.gray.opacity(0.08))
                .padding(.horizontal)
            
            HStack(spacing: 10){
                Button("cancel"){
                    showAlert = false
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                .background(.red)
                
                Button("Apply"){
                    showAlert = false
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                .background(.green)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 40)
    }
}

#Preview{
    CustomAlertOfTextView(showAlert: .constant(true))
}
