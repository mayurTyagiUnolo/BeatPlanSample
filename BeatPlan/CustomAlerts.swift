//
//  CustomAlerts.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 15/11/24.
//


import SwiftUI

struct CustomAlertsTests: View {
    @State private var showOptionAlert = false
    @State private var showReasonAlert = true
    
    var body: some View {
        ZStack {
            VStack{
                Button("Open Jai HO Alert"){
                    withAnimation{
                        showOptionAlert = true
                    }
                }
                
                Button("Open reason alert"){
                    withAnimation{
                        showReasonAlert = true
                    }
                }
            }
            
            if showOptionAlert{
                CustomAlertOfOptions(optionOne: "Option 1", optionSecond: "option 2")
                    
            }
            
            if showReasonAlert{
                CustomAlertOfTextView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertsTests()
    }
}


struct CustomAlertOfOptions: View {
    var optionOne: String
    var optionSecond: String
    
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
                    
                }
                .padding()
                
                Button("Apply"){
                    
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
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Remarks")
                .padding()
            
            TextField("Comment", text: $text, prompt: Text("Please input your comment"), axis: .vertical)
                .lineLimit(6...6)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(SwiftUI.Color.gray.opacity(0.5), lineWidth: 0.5)
                }
                .foregroundStyle(.secondary)
                .background(.gray.opacity(0.08))
                .padding(.horizontal)
            
            HStack{
                Button("cancel"){
                    
                }
                .padding()
                
                Button("Apply"){
                    
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 40)
    }
}
