import SwiftUI
  
struct BeatListView: View {
    @StateObject private var viewModel: ViewModel
    var segmentOptions: [String] = ["Beat.BeatSegmentOptions.approved.rawValue", "Beat.BeatSegmentOptions.requested.rawValue"]
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
        print("BeatListView init")
    }
    
    var body: some View {
        VStack{
            SegmentCustomStyle(selection: $viewModel.selectedSegmentIndex, options: segmentOptions)
                .padding(.top, 10)
            
            TextField(text: $viewModel.searchedText, label: {
                Text("Search here")
            })
            .padding(.horizontal, 16)
            .textFieldStyle(RoundedTextFieldStyle(text: viewModel.searchedText, innerBackgroundColor: .gray.opacity(0.2), showBorder: false))
            
            ListView(viewModel: viewModel)
            
        }
        .background(SwiftUI.Color(uiColor: VIEW_BACKGROUND_COLOR))
        .navigationTitle("Beats")
        .toolbar{
            NavigationLink{
//                CreateBeatView(viewModel: CreateBeatView.ViewModel(beatCDHelperObj: BeatCDHelper.shared))
            } label: {
                SecondaryButton(buttonTitle: "Create Beats")
            }
        }
        .onAppear{
            viewModel.fetchBeatsFromLocalDB()
        }
        .navigationDestination(isPresented: $viewModel.showBeatDetailView) {
//            if let beat = viewModel.beatToBeNavigate{
//                BeatDetailView(beat: beat)
//            }
        }
    }
    
    struct ListView: View {
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            List(viewModel.filteredBeatList, id: \.beatID){ beat in
                ZStack{
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Text(beat.beatName)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .mainTextFont()
                            
                            Spacer()
                            
                            Text("status")
                                .padding(.vertical, 2)
                                .padding(.horizontal, 10)
//                                .background(SwiftUI.Color(Utils.setStatus(status: beat.status).backgroundColor))
//                                .foregroundStyle(SwiftUI.Color(Utils.setStatus(status: beat.status).textColor))
                                .clipShape(.capsule)
                                .font(.footnote)
                            
                            Menu {
                                
                                NavigationLink("Edit") {
//                                    CreateBeatView(viewModel: CreateBeatView.ViewModel(beatCDHelperObj: BeatCDHelper.shared, beat: beat))
                                }
                                .disabled(beat.isDeleted == 1)
                                
                                Button("Delete"){
                                    viewModel.showDeleteAlert = true
                                    viewModel.beatToBeDeleted = beat
                                }
                                .disabled(beat.isDeleted == 1)
                                
                            } label: {
                                Image("threeDot")
                                    .padding(.trailing, 5)
                            }
                            
                        }
                        .background(.gray)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 10,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 10
                            )
                        )
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Total Visits: \(beat.visitList.filter{$0.isDeleted == 0}.count)")
                                .padding(.leading)
                                .font(.footnote)
                            
                            if let adminName = beat.adminName, !adminName.isEmpty{
                                Text("Created by: Admin")
                                    .padding(.leading)
                                    .font(.footnote)
                            }
                            
                            
                            if let rejectReason = beat.comment, !rejectReason.isEmpty{
                                VStack(alignment: .leading, spacing: 0){
                                    Divider()
                                    
                                    Text("Remark: \(rejectReason)")
                                        .padding(.leading)
                                        .padding(.top, 10)
                                        .font(.footnote)
                                        .frame(maxHeight: .infinity)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                    
                    Button(""){
                        viewModel.showBeatDetailView = true
                        viewModel.beatToBeNavigate = beat
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(SwiftUI.Color.gray.opacity(0.3), lineWidth: 1)
                })
                .listRowSeparator(.hidden)
                .listRowBackground(SwiftUI.Color.clear)
            }
            .listStyle(.plain)
            .listRowSpacing(3)
            .alert("Delete Confirmation", isPresented: $viewModel.showDeleteAlert, presenting: viewModel.beatToBeDeleted) { beat in
                Button("Delete", role: .destructive) {
                    viewModel.deleteBeat(beat: beat)
                }
                Button("Cancel", role: .cancel) { }
            } message: { beat in
                Text("Are you sure you want to delete \(beat.beatName)?")
            }
        }
        
    }
}




#Preview {
    BeatListView(viewModel: BeatListView.ViewModel())
}
