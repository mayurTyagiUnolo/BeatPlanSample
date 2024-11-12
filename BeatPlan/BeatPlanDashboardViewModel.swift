//
//  BeatPlanDashboardViewModel.swift
//  senseStaff
//
//  Created by Mayur  on 24/09/24.
//  Copyright © 2024 SmartSense. All rights reserved.
//

import Foundation

extension BeatPlanDashboardView{
    class ViewModel: ObservableObject{
        
        init(){
            print("BeatPlanDashboardView.ViewModel init")
        }
        
        deinit{
            print("BeatPlanDashboardView.ViewModel de-init")
        }
        
        @Published private(set) var beatPlanList: [BeatPlan] = Utils.beatPlanList
        
        func expandCollapse(beatPlan: BeatPlan){
            beatPlan.isExpanded.toggle()
            let index = beatPlanList.firstIndex(where: {$0.name == beatPlan.name})
            if let index{
                beatPlanList[index] = beatPlan
            }
        }
    }
}
