//
//  CustomAlert.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 11/11/24.
//

import SwiftUI

struct CustomAlert: View {
    @State private var showAlert: Bool = false
    @State private var name: String = ""
    
    var body: some View {
        VStack{
            Button("show alert"){
                showAlert = true
            }
        }
        .alert("Enter your name", isPresented: $showAlert) {
                  TextField("Enter your name", text: $name)
                  Button("OK", action: submit)
              } message: {
                  Text("Xcode will print whatever you type.")
              }
    }
    
    func submit() {
        print("You entered \(name)")
    }
}


#Preview{
    CustomAlert()
}
            
