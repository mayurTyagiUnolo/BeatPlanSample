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
            self.beatPlanArray = [
                BeatPlan(beatPlanID: UUID().uuidString,
                         beatPlanMetaDataID: UUID().uuidString,
                         beatID: "",
                         date: "",
                         status: Utils.beatPlanApprovalRequired ? 0 : 4,
                         expectedVisitCount: 0,
                         createdTs: "",
                         lastModifiedTs: "")
            ]
        }
        
        func getBeatName(beatID: String?) -> String?{
            beatArray.first(where: {$0.beatID == beatID})?.beatName
        }
        
        
        func newBeatPlan() -> BeatPlan{
            BeatPlan(beatPlanID: UUID().uuidString,
                     beatPlanMetaDataID: UUID().uuidString,
                     beatID: "",
                     date: "",
                     status: Utils.beatPlanApprovalRequired ? 0 : 4,
                     expectedVisitCount: 0,
                     createdTs: "",
                     lastModifiedTs: "")
        }
        
        func handleRepeatingMetaData(isOn repeatPlan: Bool, index arrayIndex: Int){
            if repeatPlan{
                beatPlanArray[arrayIndex].beatPlanMetaData = createMetaData()
            }else{
                beatPlanArray[arrayIndex].beatPlanMetaData = nil
            }
        }
        
        func createMetaData() -> BeatPlanMetaData{
            BeatPlanMetaData(beatPlanMetaDataID: UUID().uuidString, beatID: UUID().uuidString, employeeID: "", startDate: "", endDate: "", mon: false, tue: false, wed: false, thu: false, fri: false, sat: false, sun: false, createdTs: "", lastModifiedTs: "")
        }
        
        func deleteBeatPlanItem(index: Int){
            beatPlanArray.remove(at: index)
        }
    }
}
