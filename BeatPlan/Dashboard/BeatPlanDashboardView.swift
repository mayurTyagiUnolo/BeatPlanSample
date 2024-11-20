//
//  BeatPlanDashboardView.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 20/11/24.
//

import SwiftUI

struct BeatPlanDashboardView: View {
    @StateObject private var viewModel = ViewModel()
    @SwiftUI.State private var showOptionAlert: Bool = false
    @SwiftUI.State private var showReasonAlert: Bool = false
    
    //    @SwiftUI.State private var expandSearchTextField = false
    //    @SwiftUI.State private var expandDatePicker = true
    //    @SwiftUI.State private var searchText = ""
    //    @SwiftUI.State private var startDate = Date()
    //    @SwiftUI.State private var endDate = Date()
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    //                    SearchAndDateView(expandSearchTextField: $expandSearchTextField, expandDatePicker: $expandDatePicker, searchText: $searchText, startDate: $startDate, endDate: $endDate)
                    //                        .padding(.top)
                    
                    ZStack(alignment: .bottomTrailing){
                        Group {
                            if viewModel.beatPlans.isEmpty {
                                ListEmptyView(addWhat: "beat plan")
                            } else {
                                BeatPlanListView(viewModel: viewModel, showOptionAlert: $showOptionAlert, showReasonAlert: $showReasonAlert)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        NavigationLink{
//                            CreateBeatPlan(viewModel: CreateBeatPlan.ViewModel())
                        } label: {
                            Image(systemName: "plus")
                                .font(.title.weight(.semibold))
                                .padding()
                                .background(SwiftUI.Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(10)
                        .padding(.trailing, 16)
                    }
                }
//                .onAppear{
//                    viewModel.fetchBeatPlans()
//                }
                .background(SwiftUI.Color(uiColor: VIEW_BACKGROUND_COLOR))
                .navigationTitle("Beat Plan")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        CustomBackButton()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
//                            BeatListView(viewModel: BeatListView.ViewModel(beatCDHelperObj: BeatCDHelper.shared))
                        } label: {
                            SecondaryButton(buttonTitle: "View Beats")
                        }
                    }
                }
                
                if showOptionAlert{
                    CustomAlertOfOptions(optionOne: "change for one day", optionSecond: "change for all days", completionHander: optionSelected, showAlert: $showOptionAlert)
                }
                
                if showReasonAlert{
                    CustomAlertOfTextView(showAlert: $showReasonAlert, completionHandler: visitCancelled)
                }
                
            }
        }
    }
    
    func optionSelected(_ option: Int){
        switch option{
        case 1:
            print("change for one day")
        case 2:
            print("change for all days")
        default:
            break
        }
    }
    
    func visitCancelled(reason: String){
        print(reason)
    }
}

struct BeatPlanListView: View {
    @ObservedObject var viewModel: BeatPlanDashboardView.ViewModel
    @Binding var showOptionAlert: Bool
    @Binding var showReasonAlert: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(viewModel.beatPlans){ beatPlan in
                VStack{
                    HStack{
                        Text(viewModel.getBeatName(beatID: beatPlan.beatID))
                            .font(.headline)
                        
                        Spacer()
                        
//                        Text(SSDate.getDateStringFromDateString(from: beatPlan.date, in: "dd-MM-yyyy"))
                        
                        Menu{
                            NavigationLink {
//                                CreateBeatView(viewModel: CreateBeatView.ViewModel(beatCDHelperObj: BeatCDHelper.shared))
                            } label: {
                                Text("Create Add-hoc Visit")
                                Image(systemName: "plus")
                                    .foregroundStyle(.gray)
                            }
                            
                            NavigationLink {
//                                CreateBeatPlan(viewModel: CreateBeatPlan.ViewModel())
                            } label: {
                                Text("Edit")
                                Image("editPlan")
                            }
                            
                            Button{
                                // delete beatplan action
                            } label:{
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                            
                            //                                if let _ = beatPlan.beatPlanMetaDataID{
                            //                                    withAnimation{
                            //                                        showOptionAlert = true
                            //                                    }
                            //                                }else{
                            //                                    withAnimation{
                            //                                        showReasonAlert = true
                            //                                    }
                            //                                }
                            
                        } label: {
                            Image("threeDot")
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(.gray.opacity(0.1))
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: beatPlan.isExpanded ? 0 : 10,
                            bottomTrailingRadius:beatPlan.isExpanded ? 0 : 10,
                            topTrailingRadius: 10
                        )
                    )
                    .onTapGesture {
                        withAnimation {
                            viewModel.expandCollapse(beatPlan: beatPlan)
                        }
                        
                    }
                    
                    if beatPlan.isExpanded{
                        VStack{
                            VStack{
                                HStack{
                                    Text("Progress: 5/10")
                                        .font(.callout)
                                    
                                    Spacer()
                                    
                                    Text(Utils.setStatus(status: beatPlan.status).text)
                                        .padding(.vertical, 2)
                                        .padding(.horizontal, 10)
                                        .background(SwiftUI.Color(Utils.setStatus(status: beatPlan.status).backgroundColor))
                                        .foregroundStyle(SwiftUI.Color(Utils.setStatus(status: beatPlan.status).textColor))
                                        .clipShape(.capsule)
                                        .font(.footnote)
                                }
                                SwiftUI.ProgressView(value: 0.5)
                                    .tint(SwiftUI.Color(APPROVED_FORGROUND))
                                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                    
                            }
                            HStack{
                                VStack{
                                    Spacer()
                                    Text("Planned Visits")
                                }
                                
                                Spacer()
                                
                                Button{
                                    // code for optimization
                                    print("Optimized")
                                } label: {
                                    HStack{
                                        Text("Optimize")
                                            .foregroundStyle(.blue)
                                            .font(.footnote)
                                        
                                        Image("route")
                                    }
                                    .padding(5)
                                    .padding(.horizontal, 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.blue, lineWidth: 1)
                                    )
                                }
                            }
                            .padding(.vertical, 10)
                            
                            VisitView(beatID: beatPlan.beatID)
                            
                            
                            if true{
                                VStack{
                                    HStack{
                                        Text("Unplanned Visits")
                                            .padding(.bottom, 8)
                                        Spacer()
                                    }
                                    
                                    VisitView(beatID: beatPlan.beatID)
                                    
                                }
                                .padding(.top)
                                
                                
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        
                    }
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(SwiftUI.Color.gray.opacity(0.3), lineWidth: 1)
                })
            }
        }
        .padding()
        
    }
    
}
struct VisitView: View {
    var beatID: String
    
    var body: some View {
        ForEach(1..<3){_ in
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    Image("beatClient")
                    
                    Text("Client Name")
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 24, height: 24)
//                        .foregroundStyle(.clear)
                        .foregroundStyle(SwiftUI.Color(REJECTED_BACKGROUND))
//                        .foregroundStyle(SwiftUI.Color(APPROVED_BACKGROUND))
                        .overlay {
//                            Image("beat_check")
                            Image("beat_close")
                        }
                }
                .padding(5)
                
                Divider()
                
                HStack(){
                    VStack{
                        Image("addressIcon")
                        Spacer()
                    }
                    .padding(.top, 12)
                    
                    Text("visit address: like Golf courrse road and this might be multi line address")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.callout)
                }
                .padding(5)
                
                HStack{
                    Image("taskIcon")
                    Text("Task name")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.callout)
                }
                .padding(5)
                
                HStack{
                    Image("scheduleIcon")
                    Text("start and end time")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.callout)
                }
                .padding(5)
                
                HStack{
                    Image("remarkIcon")
                    Text("Remark: short remark")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.callout)
                }
                .padding(5)
                
                HStack{
                    ActionButtons(btnImage: "call", btnText: "Call", action: callBtnPressed)
                        .frame(maxWidth: .infinity)
                    ActionButtons(btnImage: "navigate", btnText: "Navigate", action: navigateBtnPressed)
                        .frame(maxWidth: .infinity)
                    ActionButtons(btnImage: "planCancelIcon", btnText: "Cancel", action: canceBtnPressed)
                        .frame(maxWidth: .infinity)
                    
                }
                .frame(height: 40)
                .padding([.horizontal, .top], 5)
                
                ActionButtons(btnText: "Start Task", action: startTaskBtnPressed, tintColor: .blue, fontColor: .blue, textFont: .callout)
                    .padding([.horizontal, .bottom], 5)
            }
            .padding(10)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(SwiftUI.Color.gray.opacity(0.1), lineWidth: 2)
            })
        }
        
        
        
        
        
        
    }
    
    func callBtnPressed(){
        // action on call btn pressed
        print("call btn preesssed")
    }
    func navigateBtnPressed(){
        print("navigate btn preesssed")
        // action on navigation btn pressed
    }
    func canceBtnPressed(){
        print("cancel btn pressed")
        // acstiobn on cancel btn pressed
    }
    func startTaskBtnPressed(){
        // start task btn pressed
        print("task started")
    }
}

struct ActionButtons: View {
    var btnImage: String?
    var btnText: String
    var action: () -> Void
    var tintColor: SwiftUI.Color = .gray
    var fontColor: SwiftUI.Color = .black
    var textFont: Font = .footnote
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack(spacing: 0){
                if let btnImage{
                    Image(btnImage)
                        .padding(.trailing, 4)
                }
                
                Text(btnText)
                    .font(textFont)
                    .font(.system(size: 15))
                    .foregroundStyle(fontColor.opacity(0.8))
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, minHeight: 35)
            .overlay(
                Capsule()
                    .stroke(tintColor, lineWidth: 1)
            )
        }
        
    }
}

//struct SearchAndDateView: View{
//    @Binding var expandSearchTextField: Bool
//    @Binding var expandDatePicker: Bool
//    @Binding var searchText: String
//    @Binding var startDate: Date
//    @Binding var endDate: Date
//
//    var body: some View{
//        HStack{
//            if expandSearchTextField{
//                TextField("search here", text: $searchText)
//                    .padding(.leading)
//            }else{
//                DatePicker("please select the date", selection: $startDate, displayedComponents: .date)
//                    .labelsHidden()
//                DatePicker("please select the date", selection: $endDate, displayedComponents: .date)
//                    .labelsHidden()
//            }
//            Button{
//                // code for search
//            } label: {
//                Image(systemName: "magnifyingglass.circle.fill")
//                    .font(.largeTitle)
//            }
//        }
//    }
//}

#Preview{
    BeatPlanDashboardView()
}
