//
//  Utils.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 01/10/24.
//
import Foundation

class Utils {
    static let authorisation = Authorization()
    
    
    struct Authorization {
        let clients = 1
    }
    
    
    
    static let visit = Utils.getVisitList()
    
    static var beatApprovalRequired: Bool = true
    static var beatPlanApprovalRequired: Bool = true
    
    static func getCustomTask() -> [String]{
        return ["task1", "task2", "task3", "task4", "task5"]
    }
    
    static func getVisitList() -> [Visit] {
        var visitList = [Visit]()
        for i in 1...10{
            let visit = Visit(beatVisitID: UUID().uuidString, visitType: 1, visitAddress: "addess", visitName: "client \(i)", lat: 1, lon: 1, radius: 11, clientID: UUID().uuidString, startTime: "", endTime: "", taskType: "task2", sequence: 1, isDeleted: 0, mainOrStaged: 1, createdTs: "", lastModifiedTs: "")
            visitList.append(visit)
            
        }
        return visitList
    }
    
    static let beat = Beat(beatID: UUID().uuidString, beatName: "Beat 1", status: 1, isDeleted: 0, mainOrStaged: 1, visitList: Utils.getVisitList(), createdTs: "", lastModifiedTs: "")
    
    
    
}



extension Utils{
    
    
    static let beatArray = [
        Beat(beatID: UUID().uuidString, beatName: "Beat 1", status: 1, isDeleted: 0, mainOrStaged: 1, visitList: Utils.getVisitList(), createdTs: "", lastModifiedTs: ""),
        Beat(beatID: UUID().uuidString, beatName: "Beat 2", status: 1, isDeleted: 0, mainOrStaged: 1, visitList: Utils.getVisitList(), createdTs: "", lastModifiedTs: ""),
        Beat(beatID: UUID().uuidString, beatName: "Beat 3", status: 1, isDeleted: 0, mainOrStaged: 1, visitList: Utils.getVisitList(), createdTs: "", lastModifiedTs: "")
        ]
    
}

