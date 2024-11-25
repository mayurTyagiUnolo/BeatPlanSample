import HorizonCalendar
import SwiftUI


struct BeatPlanDashboardView: View {
    @SwiftUI.State private var expandDatePicker = true
    @SwiftUI.State private var expandSearchTextField = false
    @SwiftUI.State private var showFilterOptions: Bool = false
    @SwiftUI.State private var searchedText = ""
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    // Top view
                    HStack{
                        
                        DateRangePickerView(expandDatePicker: $expandDatePicker, expandSearchTextField: $expandSearchTextField)
                        
                        SearchTextView(expandDatePicker: $expandDatePicker, expandSearchTextField: $expandSearchTextField, searchedText: $searchedText)
                        
                        FilterView(showFilterOptions: $showFilterOptions)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.top, .horizontal])
                    .padding(.bottom, 10)
                    .background(.orange)
                    
                    ScrollView{
                        ForEach(1..<100){ i in
                            Text("Item \(i)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.gray.opacity(0.1))
                        }
                    }
                }
            }
            .background(.green)
        }
    }
}


#Preview {
    BeatPlanDashboardView()
}


struct DateRangePickerView: View {
    @Binding var expandDatePicker: Bool
    @Binding var expandSearchTextField: Bool
    
    var body: some View{
        HStack{
            if self.expandDatePicker{
                HStack(spacing: 0){
                    Text("Start Date")
                        .lineLimit(1)
                    Text("End Date")
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image("custom_task_calendar")
                    .padding(.horizontal, 8)
            }
            else{
                Button(action: {
                    withAnimation {
                        self.expandSearchTextField.toggle()
                        self.expandDatePicker.toggle()
                    }
                }) {
                    Image("custom_task_calendar")
                        .foregroundColor(.black)
                }
            }
        }
        .frame(height: 25)
        .padding(10)
        .background(SwiftUI.Color.white)
        .clipShape(
            expandDatePicker ? RoundedRectangle(cornerRadius: 55) :  RoundedRectangle(cornerRadius: 200)
        )

    }
}


struct SearchTextView: View {
    @Binding var expandDatePicker: Bool
    @Binding var expandSearchTextField: Bool
    @Binding var searchedText: String
 
    var body: some View {
        
        HStack{
            if self.expandSearchTextField{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 8)
                    TextField("Search Food", text: self.$searchedText)
                        
                    
                    Button(action: {
                        withAnimation {
                            self.searchedText = ""
                            self.expandSearchTextField.toggle()
                            self.expandDatePicker.toggle()
                        }
                    }) {
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                }
            }
            else{
                Button(action: {
                    withAnimation {
                        self.expandSearchTextField.toggle()
                        self.expandDatePicker.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .frame(height: 25)
        .padding(10)
        .background(SwiftUI.Color.white)
        .clipShape(
            expandSearchTextField ? RoundedRectangle(cornerRadius: 55) : RoundedRectangle(cornerRadius: 200)
        )
    }
    
}


struct FilterView: View {
    @Binding var showFilterOptions: Bool
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        Menu("Hello"){
            Button(role: .destructive){
            showDatePicker = true
            showFilterOptions = true
            //            SwiftUIScreenDemo(calendar: Calendar.current, monthsLayout: MonthsLayout.vertical(options: VerticalMonthsLayoutOptions()))
        } label: {
            Text("trash")
            Image(systemName: "trash")
                .foregroundStyle(.red)
        }
        .frame(height: 25)
        .padding(12)
        .background(SwiftUI.Color.white)
        .clipShape(.circle)
        .sheet(isPresented: $showDatePicker) {
            AirbnbDateRangePicker(calendar: Calendar.current, monthsLayout: MonthsLayout.vertical(options: VerticalMonthsLayoutOptions(pinDaysOfWeekToTop: false, alwaysShowCompleteBoundaryMonths: false, scrollsToFirstMonthOnStatusBarTap: false)), dateHandler: dateRangeSelected)
        }
    }
    }
    
    func dateRangeSelected(startDate: String, endDate: String){
        print(startDate, endDate)
    }
}

