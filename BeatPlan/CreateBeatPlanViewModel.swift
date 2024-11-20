//
//  CreateBeatPlanViewModel.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 08/11/24.
//
import SwiftUI

extension CreateBeatPlan{
    class ViewModel: ObservableObject{
        var beatArray: [Beat] = []
        @Published var beatPlanArray = [BeatPlan]()
        
        init() {
            self.beatArray = Utils.beatArray // get beat from BeatCDHelper
            self.beatPlanArray = [newBeatPlan()]
        }
        
        func getBeatName(beatID: String?) -> String?{
            beatArray.first(where: {$0.beatID == beatID})?.beatName
        }
        
        func getVisitCount(beatID: String) -> Int{
            beatArray.first(where: {$0.beatID == beatID})?.visitList.filter({$0.isDeleted != 1}).count ?? 0
        }
        
        
        func newBeatPlan() -> BeatPlan{
            BeatPlan(beatPlanID: UUID().uuidString,
                     beatID: "",
                     date: "",
                     status: Utils.beatPlanApprovalRequired ? 0 : 4,
                     expectedVisitCount: 0,
                     createdTs: "",
                     lastModifiedTs: "")
        }
        
        func handleRepeatingMetaData(isOn repeatPlan: Bool, index arrayIndex: Int){
            if repeatPlan{
                let newMetaData = createMetaData()
                beatPlanArray[arrayIndex].beatPlanMetaData = newMetaData
                beatPlanArray[arrayIndex].beatPlanMetaDataID = newMetaData.beatPlanMetaDataID
            }else{
                beatPlanArray[arrayIndex].beatPlanMetaData = nil
                beatPlanArray[arrayIndex].beatPlanMetaDataID = nil
            }
        }
        
        func createMetaData() -> BeatPlanMetaData{
            BeatPlanMetaData(beatPlanMetaDataID: UUID().uuidString, beatID: "", employeeID: Utils.employeeID, startDate: "", endDate: "", mon: false, tue: false, wed: false, thu: false, fri: false, sat: false, sun: false, createdTs: "", lastModifiedTs: "")
        }
        
        func deleteBeatPlanItem(index: Int){
            beatPlanArray.remove(at: index)
        }
        
        func saveBeatPlanAndMetaData(){
            var metaDataArray = [BeatPlanMetaData]()
            for beatPlan in beatPlanArray{
                beatPlan.expectedVisitCount = getVisitCount(beatID: beatPlan.beatID)
                
                if let metaData = beatPlan.beatPlanMetaData{
                    metaData.beatID = beatPlan.beatID
                    metaDataArray.append(metaData)
                }
                
                dump(beatPlanArray)
                
                dump(metaDataArray)
                
                // save beatPlan metaData in CoreData
                
                // save beatPlan in CoreData
                
            }
        }
    }
}

struct ListEmptyView: View {
    var addWhat: String = "visits"
    
    var body: some View {
            VStack(spacing: 10){
                Text("List is empty")
                    .font(.system(size: 20, weight: .bold))
                Text("Press + button to add \(addWhat)")
                    .foregroundStyle(.secondary)
            }
    }
}
