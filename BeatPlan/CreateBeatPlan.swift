import SwiftUI

struct CreateBeatPlan: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel = CreateBeatPlan.ViewModel()
    
    @SwiftUI.State private var selectedDays: [Day] = []
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.beatPlanArray.indices, id: \.self) { index in

                    BeatPlanRow(viewModel: viewModel, beatPlan: $viewModel.beatPlanArray[index], rowIndex: index)
                    
                    if index == viewModel.beatPlanArray.count - 1 {
                        HStack {
                            Spacer()
                            Button("+ Add more") {
                                withAnimation {
                                    viewModel.beatPlanArray.append(viewModel.newBeatPlan())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }else {
                        Divider()
                            .padding()
                    }
                   
                    
                }
            }
            
            
//            Spacer()
            
            BottomSaveButton(buttonTitle: "Save") {
                saveButtonTapped()
            }
        }
        .navigationTitle("Schedule Beat Plan")
        .navigationBarTitleDisplayMode(.inline)
        .background(SwiftUI.Color(uiColor: VIEW_BACKGROUND_COLOR))
    }
    
    private func saveButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BeatPlanRow: View {
    @SwiftUI.State private var repeatPlan: Bool = false
    @ObservedObject var viewModel: CreateBeatPlan.ViewModel
    @Binding var beatPlan: BeatPlan
    var rowIndex: Int

    var body: some View {
        HStack{
            VStack {
                BeatPicker(viewModel: viewModel, selectedBeatID: $beatPlan.beatID)
                
                DatePickerLabel(label: "Start on", dateString: $beatPlan.date)
                    .padding()
                
                Toggle(isOn: $repeatPlan.animation()) {
                    Text("Repeat")
                }
                .padding(.horizontal)
                .tint(.accentColor)
                .onChange(of: repeatPlan) { newValue in
                    withAnimation{
                        viewModel.handleRepeatingMetaData(isOn: newValue, index: rowIndex)
                    }
                }
                
                if repeatPlan {
                    VStack {
                        HStack {
                            let startDate = Binding<String?>(
                                get: {beatPlan.beatPlanMetaData?.startDate},
                                set: {newValue in beatPlan.beatPlanMetaData?.startDate = newValue ?? ""}
                            )
                            
                            SecondDatePickerLabel(label: "Start Date", dateString: startDate)
                                .padding(.leading)
                            
                            let endDate = Binding<String?>(
                                get: {beatPlan.beatPlanMetaData?.endDate},
                                set: {newValue in beatPlan.beatPlanMetaData?.endDate = newValue ?? ""}
                            )
                            
                            SecondDatePickerLabel(label: "End Date", dateString: endDate)
                                .padding(.trailing)
                        }
                        
//                        DaysPicker(selectedDays: $selectedDays)
//                            .padding([.horizontal, .top])
                    }
                }
            }
            .padding()
            
            if viewModel.beatPlanArray.count > 1{
                Button("", systemImage: "trash") {
                    // code for delete the beat Paln item
                }
                .tint(.red)
                .padding(.trailing)
            }
        }
    }
}


#Preview {
    CreateBeatPlan()
}

struct BeatPicker: View {
    var viewModel: CreateBeatPlan.ViewModel
    @Binding var selectedBeatID: String
    
    var body: some View {
        Menu {
            Picker("", selection: $selectedBeatID) {
                ForEach(viewModel.beatArray, id: \.beatID) { beat in
                    Text(beat.beatName)
                        .tag(beat.beatID)
                }
            }
        } label: {
            HStack {
                Text(viewModel.getBeatName(beatID: selectedBeatID) ?? "Select Beat")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .frame(height: 40)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(SwiftUI.Color.gray.opacity(0.2), lineWidth: 1)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}

struct DatePickerLabel: View {
    var label: String
    @Binding var dateString: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .padding(.horizontal)
            
            Spacer()
            
            DatePicker(
                "",
                selection: Binding(
                    get: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                         let date = dateFormatter.date(from: dateString)
                        return date ?? Date()
                         
                    },
                    set: { newDate in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        dateString = dateFormatter.string(from: newDate)
                    }
                ),
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .labelsHidden()
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(SwiftUI.Color(UIColor.secondarySystemBackground))
        .foregroundColor(.primary)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: SwiftUI.Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(SwiftUI.Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}



struct SecondDatePickerLabel: View {
    let label: String
    @Binding var dateString: String?
    
    var body: some View {
        Label(dateString ?? "\(label)", systemImage: "calendar")
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.2), lineWidth: 1)
            )
            .overlay {
                DatePicker(
                    "",
                    selection: Binding(
                        get: {
                            // Convert optional timeString to Date or use current date if nil
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            if let dateString = dateString, let date = dateFormatter.date(from: dateString) {
                                return date
                            } else {
                                return Date()
                            }
                        },
                        set: { newDate in
                            // Convert Date back to optional timeString
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateString = dateFormatter.string(from: newDate)
                        }
                    ),
                    displayedComponents: .date
                )
                .labelsHidden()
                .colorMultiply(.clear)
            }
    }
}


struct DaysPicker: View {
    @Binding var selectedDays: [Day]
    
    var body: some View {
        HStack() {
            ForEach(Day.allCases, id: \.self) { day in
                Text(String(day.rawValue.first!))
//                    .bold()
                    .foregroundColor(selectedDays.contains(day) ? .white : .black)
                    .frame(width: 40, height: 30)
                    .background(selectedDays.contains(day) ? .blue : .white)
                    .clipShape(.capsule)
                    .overlay(
                        Capsule()
                            .stroke(.gray.opacity(0.1), lineWidth: 1)
                    )
                    .onTapGesture {
                        if selectedDays.contains(day) {
                            selectedDays.removeAll(where: {$0 == day})
                        } else {
                            selectedDays.append(day)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


enum Day: String, CaseIterable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}
