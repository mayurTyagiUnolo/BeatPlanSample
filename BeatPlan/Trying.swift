//
//  Trying.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 08/11/24.
//

import SwiftUI

struct CustomDatePickerStyle: UIViewRepresentable {
    @Binding var selectedDate: Date
    
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }
    
    func updateUIView(_ view: UIDatePicker, context: Context) {
        view.date = selectedDate
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: CustomDatePickerStyle
        
        init(_ parent: CustomDatePickerStyle) {
            self.parent = parent
        }
        
        @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
            parent.selectedDate = datePicker.date
        }
    }
}

struct ContentView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("Selected Date: \(selectedDate, style: .date)")
                .font(.title)
                .padding()
            
            CustomDatePickerStyle(selectedDate: $selectedDate)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
