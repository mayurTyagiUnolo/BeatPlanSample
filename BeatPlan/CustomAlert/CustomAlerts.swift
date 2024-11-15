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
    @State private var optionOneSelected: Bool = true
    @State private var optionSecondSelected: Bool = false
    
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 30){
                Button{
                    optionOneSelected.toggle()
                    optionSecondSelected.toggle()
                } label: {
                    HStack{
                        Image(systemName: optionOneSelected ? "record.circle" : "circle")
                            .foregroundStyle(optionOneSelected ? .blue : .gray)
                            .font(.title)
                        Text(optionOne)
                            .foregroundStyle(.black)
                    }
                }
                
                Button{
                    optionOneSelected.toggle()
                    optionSecondSelected.toggle()
                } label: {
                    HStack{
                        Image(systemName: optionSecondSelected ? "record.circle" : "circle")
                            .font(.caption)
                            .foregroundStyle(optionSecondSelected ? .blue : .gray)
                        Text(optionSecond)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
            
            HStack{
                Spacer()
                
                Button("Cancel"){
                    showAlert = false
                }
                .foregroundStyle(.gray)
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
            
            TextField("Comment", text: $text, prompt: Text("Write your comment here..."), axis: .vertical)
                .lineLimit(6...6)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(SwiftUI.Color.gray.opacity(0.5), lineWidth: 0.5)
                }
                .foregroundStyle(.secondary)
                .background(.gray.opacity(0.05))
                .padding(.horizontal)
            
            HStack(spacing: 20){
                Button("Go Back"){
                    showAlert = false
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                .background(.gray.opacity(0.2))
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("Cancel Visit"){
                    showAlert = false
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0))
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
    CustomAlertOfOptions(optionOne: "change only today's plan", optionSecond: "change all scheduled plan", showAlert: (.constant(true)))
}
