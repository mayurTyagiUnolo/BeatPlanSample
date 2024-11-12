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
                         status: Utils.beatApprovalRequired ? 0 : 4,
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
                     status: Utils.beatApprovalRequired ? 0 : 4,
                     expectedVisitCount: 0,
                     createdTs: "",
                     lastModifiedTs: "")
        }
    }
}
