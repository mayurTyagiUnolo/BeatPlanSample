//
//  BeatPlanApp.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 07/11/24.
//

import SwiftUI

@main
struct BeatPlanApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                CreateBeatPlan()
//                CustomAlertController()
            }
        }
    }
}
