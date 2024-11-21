//
//  Beat.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 08/10/24.
//

class Beat{
    var beatID: String
    var beatName: String
    var status: Int?
    var isDeleted: Int
    var mainOrStaged: Int
    var visitList: [Visit]
    var adminName: String?
    var comment: String?
    var rejectReason: String?
    var createdTs: String
    var lastModifiedTs: String
    
    init(beatID: String, beatName: String, status: Int?, isDeleted: Int, mainOrStaged: Int, visitList: [Visit], adminName: String? = nil, comment: String? = nil, rejectReason: String? = nil, createdTs: String, lastModifiedTs: String) {
        self.beatID = beatID
        self.beatName = beatName
        self.status = status
        self.isDeleted = isDeleted
        self.mainOrStaged = mainOrStaged
        self.visitList = visitList
        self.adminName = adminName
        self.comment = "rejected due to invalid visits rejected due to invalid visits rejected due to invalid visits rejected due to invalid visitsrejected due to invalid visitsrejected due to invalid visits rejected due to invalid visits rejected due to invalid visits"
        self.rejectReason = rejectReason
        self.createdTs = createdTs
        self.lastModifiedTs = lastModifiedTs
    }
    
    enum MainOrStaged: Int {
        case staged = 0
        case main = 1
    }
    
    enum Status: Int{
        case rejected = 0
        case approved = 1
        case pending = 2
        case notRequired = 4
    }
    
    enum IsDeleted: Int{
        case no = 0
        case yes = 1
    }
}

public class Visit {
    var beatVisitID: String
    var visitType: Int
    var visitAddress: String
    var visitName: String
    var lat: Double
    var lon: Double
    var radius: Int
    var clientID: String?
    var startTime: String?
    var endTime: String?
    var taskType: String?
    var sequence: Int
    var isDeleted: Int
    var mainOrStaged: Int
    var createdTs: String
    var lastModifiedTs: String
    
    init(beatVisitID: String, visitType: Int, visitAddress: String, visitName: String, lat: Double, lon: Double, radius: Int, clientID: String?, startTime: String?, endTime: String?, taskType: String?, sequence: Int, isDeleted: Int, mainOrStaged: Int, createdTs: String, lastModifiedTs: String) {
        self.beatVisitID = beatVisitID
        self.visitType = visitType
        self.visitAddress = visitAddress
        self.visitName = visitName
        self.lat = lat
        self.lon = lon
        self.radius = radius
        self.clientID = clientID
        self.startTime = startTime
        self.endTime = endTime
        self.taskType = taskType
        self.sequence = sequence
        self.isDeleted = isDeleted
        self.mainOrStaged = mainOrStaged
        self.createdTs = createdTs
        self.lastModifiedTs = lastModifiedTs
    }
    
    enum VisitType: Int{
        case client = 0
        case site = 1
        case locaation = 2
    }
}


class Location{
    var placeID: String
    var lat: Double
    var lon: Double
    var radius: Int
    var locationName: String
    var locationAddress: String
    
    init(placeID: String, lat: Double, lon: Double, radius: Int, locationName: String, locationAddress: String) {
        self.placeID = placeID
        self.lat = lat
        self.lon = lon
        self.radius = radius
        self.locationName = locationName
        self.locationAddress = locationAddress
    }
}
