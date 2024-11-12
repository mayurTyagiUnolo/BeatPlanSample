//
//  BeatPlan.swift
//  BeatPlanSampleProject
//
//  Created by Mayur Tyagi on 29/10/24.
//



class BeatPlan: Identifiable{
    var id: String { beatPlanID }
    
    var beatPlanID: String
    var beatPlanMetaDataID: String
    var beatID: String
    var date: String
    var status: Int
    var optRouteByEmp: String?
    var optDistanceByEmp: Float?
    var optRouteByAdmin: String?
    var optDistanceByAdmin: Float?
    var expectedVisitCount: Int
    var actualDistance: Float?
    var actualRoute: Int?
    var actualVisitCount: Int?
    var comment: String?
    var beatPlanVisitDetails: BeatPlanVisitDetails?
    var beatPlanAdhocVisitDetails: BeatPlanAdhocVisitDetails?
    var createdByAdminID: Int?
    var lastModifiedByAdminID: Int?
    var createdByEmployeeID: Int?
    var lastModifiedByEmployeeID: Int?
    var createdTs: String
    var lastModifiedTs: String
    
    var isExpanded: Bool = false // to expand or collapse in beat plan list
    
    init(beatPlanID: String, beatPlanMetaDataID: String, beatID: String, date: String, status: Int, optRouteByEmp: String? = nil, optDistanceByEmp: Float? = nil, optRouteByAdmin: String? = nil, optDistanceByAdmin: Float? = nil, expectedVisitCount: Int, actualDistance: Float? = nil, actualRoute: Int? = nil, actualVisitCount: Int? = nil, comment: String? = nil, beatPlanVisitDetails: BeatPlanVisitDetails? = nil, beatPlanAdhocVisitDetails: BeatPlanAdhocVisitDetails? = nil, createdByAdminID: Int? = nil, lastModifiedByAdminID: Int? = nil, createdByEmployeeID: Int? = nil, lastModifiedByEmployeeID: Int? = nil, createdTs: String, lastModifiedTs: String) {
        self.beatPlanID = beatPlanID
        self.beatPlanMetaDataID = beatPlanMetaDataID
        self.beatID = beatID
        self.date = date
        self.status = status
        self.optRouteByEmp = optRouteByEmp
        self.optDistanceByEmp = optDistanceByEmp
        self.optRouteByAdmin = optRouteByAdmin
        self.optDistanceByAdmin = optDistanceByAdmin
        self.expectedVisitCount = expectedVisitCount
        self.actualDistance = actualDistance
        self.actualRoute = actualRoute
        self.actualVisitCount = actualVisitCount
        self.comment = comment
        self.beatPlanVisitDetails = beatPlanVisitDetails
        self.beatPlanAdhocVisitDetails = beatPlanAdhocVisitDetails
        self.createdByAdminID = createdByAdminID
        self.lastModifiedByAdminID = lastModifiedByAdminID
        self.createdByEmployeeID = createdByEmployeeID
        self.lastModifiedByEmployeeID = lastModifiedByEmployeeID
        self.createdTs = createdTs
        self.lastModifiedTs = lastModifiedTs
    }
}

class BeatPlanVisitDetails: Identifiable {
    var id: String { beatVisitID }
    
    var beatPlanID: String
    var beatVisitID: String
    var comment: String
    
    init(beatPlanID: String, beatVisitID: String, comment: String) {
        self.beatPlanID = beatPlanID
        self.beatVisitID = beatVisitID
        self.comment = comment
    }
}

class BeatPlanAdhocVisitDetails {
    var beatPlanID: String
    var taskID: String?
    var taskType: String?
    var clientID: String?
    var lat: Double?
    var lon: Double?
    var radius: Int?
    
    init(beatPlanID: String, taskID: String? = nil, taskType: String? = nil, clientID: String? = nil, lat: Double? = nil, lon: Double? = nil, radius: Int? = nil) {
        self.beatPlanID = beatPlanID
        self.taskID = taskID
        self.taskType = taskType
        self.clientID = clientID
        self.lat = lat
        self.lon = lon
        self.radius = radius
    }
}
