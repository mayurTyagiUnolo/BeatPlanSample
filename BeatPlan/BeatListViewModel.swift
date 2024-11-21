//
//  BeatListViewModel.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 18/10/24.
//
import SwiftUI

extension BeatListView{
    class ViewModel: ObservableObject{
//        var beatCDHelperObj: BeatCDHelper // CDHelper Obj to fetch beats from the Local DB
        
        @Published var beatList = [Beat]() // All Beats Saved in Local DB
        @Published var selectedSegmentIndex = 0
        @Published var searchedText = ""
        
        @Published var showDeleteAlert = false
        @Published var beatToBeDeleted: Beat? // selected beat for deletion when tapped on the delete btn for that particular beat.
        
        @Published var showBeatDetailView = false
        @Published var beatToBeNavigate: Beat? // selected beat for detail View when tapped on that particular beat.
        
        var filteredBeatList: [Beat]{
            if selectedSegmentIndex == 0{
                // filter for approved Segment - isDelete should be zero, and filter the beat name by searcherd Text.
                beatList.filter{ $0.mainOrStaged == Beat.MainOrStaged.main.rawValue && $0.isDeleted == 0 && filterForSearchedText(beat: $0) }
            }else{
                // filter for requested Segment - remove the approved deleted beats and filter the beat name by searcherd Text.
                beatList.filter{ $0.mainOrStaged == Beat.MainOrStaged.staged.rawValue && !($0.status == Beat.Status.approved.rawValue && $0.isDeleted == 1) && filterForSearchedText(beat: $0) }
            }
        }
        
        init() {
//            self.beatCDHelperObj = beatCDHelperObj
            print("BeatListView init")
        }
        
        deinit{
            print("BeatListView de-init")
        }
        
        // filter beats based on the searched text.
        func filterForSearchedText(beat: Beat) -> Bool{
            let searchedText = self.searchedText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let beatName = beat.beatName.lowercased()
            if searchedText.isEmpty{
                return true
            }
            
            return beatName.contains(searchedText)
        }
        
        // fetching all saved beats from the local DB
        func fetchBeatsFromLocalDB(){
                beatList = Utils.beatArray
        }
        
        // Delete the beat...
        func deleteBeat(beat: Beat){
            beat.isDeleted = 1
//            beat.status = Utils.approvalEnabledOnBeat ? Beat.Status.pending.rawValue : Beat.Status.notRequired.rawValue
//            beat.mainOrStaged = Utils.approvalEnabledOnBeat ? Beat.MainOrStaged.staged.rawValue : Beat.MainOrStaged.main.rawValue
            beat.visitList = beat.visitList.map{ visit in
                visit.isDeleted = 1
                visit.mainOrStaged = beat.mainOrStaged
                return visit
            }
//            beat.lastModifiedTs = SSDate.getStringCurrentTimeStampInMS()
            
            // save beat to Local DB after changes.
//            beatCDHelperObj.saveBeat(beat: beat)
        }
    }
}
