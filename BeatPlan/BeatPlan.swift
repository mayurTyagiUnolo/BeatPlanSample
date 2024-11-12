//
//  BeatPlan.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 29/10/24.
//

class BeatPlan {
    var name: String
    var visits: [Visit]
    var isExpanded: Bool = true
    
    init(name: String, visits: [Visit]) {
        self.name = name
        self.visits = visits
    }
}
