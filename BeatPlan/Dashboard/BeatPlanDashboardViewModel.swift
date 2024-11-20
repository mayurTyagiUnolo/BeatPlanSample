
import Foundation
import SwiftUI


extension BeatPlanDashboardView{
    class ViewModel: ObservableObject{
        
        @Published private(set) var beatPlans: [BeatPlan] = []
        
        init(){
            
            self.beatPlans = Utils.dummyBeatPlanArray
            
            if beatPlans.count == 1{
                beatPlans.first?.isExpanded = true
            }
            
            print("BeatPlanDashboardView.ViewModel init")
        }
        
        deinit{
            print("BeatPlanDashboardView.ViewModel de-init")
        }
        
        
        func expandCollapse(beatPlan: BeatPlan){
            beatPlan.isExpanded.toggle()
            objectWillChange.send()
        }
        
        func getBeatName(beatID: String) -> String{
//            BeatCDHelper.shared.getBeat(beatID: beatID, mainOrStage: 1)?.beatName ?? "UnKnown"
            "UnKnown"
        }
    }
}


extension Utils{
    static var dummyBeatPlanArray = [
//        BeatPlan(beatPlanID: UUID().uuidString, beatPlanMetaDataID: UUID().uuidString, beatID: UUID().uuidString, date: "2024-11-02", status: 2, expectedVisitCount: 2, createdTs: "123", lastModifiedTs: "123"),
//        BeatPlan(beatPlanID: UUID().uuidString, beatPlanMetaDataID: UUID().uuidString, beatID: UUID().uuidString, date: "2024-11-02", status: 2, expectedVisitCount: 2, createdTs: "123", lastModifiedTs: "123"),
        BeatPlan(beatPlanID: UUID().uuidString, beatPlanMetaDataID: UUID().uuidString, beatID: UUID().uuidString, date: "2024-11-02", status: 2, expectedVisitCount: 2, createdTs: "123", lastModifiedTs: "123")
    ]
}
