//
//  BeatPlan.swift
//  senseStaff
//
//  Created by Mayur Tyagi on 07/11/24.
//  Copyright © 2024 SmartSense. All rights reserved.
//

import UIKit

class BeatPlan: Identifiable, Equatable{
    static func == (lhs: BeatPlan, rhs: BeatPlan) -> Bool {
            return lhs.beatPlanID == rhs.beatPlanID &&
                   lhs.beatPlanMetaDataID == rhs.beatPlanMetaDataID &&
                   lhs.beatID == rhs.beatID &&
                   lhs.date == rhs.date &&
                   lhs.status == rhs.status &&
                   lhs.optRouteByEmp == rhs.optRouteByEmp &&
                   lhs.optDistanceByEmp == rhs.optDistanceByEmp &&
                   lhs.optRouteByAdmin == rhs.optRouteByAdmin &&
                   lhs.optDistanceByAdmin == rhs.optDistanceByAdmin &&
                   lhs.expectedVisitCount == rhs.expectedVisitCount &&
                   lhs.actualDistance == rhs.actualDistance &&
                   lhs.actualRoute == rhs.actualRoute &&
                   lhs.actualVisitCount == rhs.actualVisitCount &&
                   lhs.comment == rhs.comment &&
                   lhs.createdByAdminID == rhs.createdByAdminID &&
                   lhs.lastModifiedByAdminID == rhs.lastModifiedByAdminID &&
                   lhs.createdByEmployeeID == rhs.createdByEmployeeID &&
                   lhs.lastModifiedByEmployeeID == rhs.lastModifiedByEmployeeID &&
                   lhs.createdTs == rhs.createdTs &&
                   lhs.lastModifiedTs == rhs.lastModifiedTs &&
                   lhs.beatPlanMetaData?.beatPlanMetaDataID == rhs.beatPlanMetaData?.beatPlanMetaDataID
        }
    
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
//    var isRepeated: Bool = false // to repeat beat Plan for multiple days for selecte date range.
    var beatPlanMetaData: BeatPlanMetaData?
    
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

public class BeatPlanVisitDetails: NSObject, Identifiable {
    public var id: String { beatVisitID }
    
    var beatPlanID: String
    var beatVisitID: String
    var comment: String
    
    init(beatPlanID: String, beatVisitID: String, comment: String) {
        self.beatPlanID = beatPlanID
        self.beatVisitID = beatVisitID
        self.comment = comment
    }
}

public class BeatPlanAdhocVisitDetails: NSObject {
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


class BeatPlanMetaData{
    var beatPlanMetaDataID: String
    var beatID: String
    var employeeID: String
    var startDate: String
    var endDate: String
    var mon: Bool
    var tue: Bool
    var wed: Bool
    var thu: Bool
    var fri: Bool
    var sat: Bool
    var sun: Bool
    var createdTs: String
    var lastModifiedTs: String
    
    init(beatPlanMetaDataID: String, beatID: String, employeeID: String, startDate: String, endDate: String, mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool, createdTs: String, lastModifiedTs: String) {
        self.beatPlanMetaDataID = beatPlanMetaDataID
        self.beatID = beatID
        self.employeeID = employeeID
        self.startDate = startDate
        self.endDate = endDate
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
        self.sun = sun
        self.createdTs = createdTs
        self.lastModifiedTs = lastModifiedTs
    }
}

extension BeatPlanMetaData {
    var selectedDaysArray: [Day] {
        get {
            var days = [Day]()
            if mon { days.append(.Monday) }
            if tue { days.append(.Tuesday) }
            if wed { days.append(.Wednesday) }
            if thu { days.append(.Thursday) }
            if fri { days.append(.Friday) }
            if sat { days.append(.Saturday) }
            if sun { days.append(.Sunday) }
            return days
        }
        set {
            mon = newValue.contains(.Monday)
            tue = newValue.contains(.Tuesday)
            wed = newValue.contains(.Wednesday)
            thu = newValue.contains(.Thursday)
            fri = newValue.contains(.Friday)
            sat = newValue.contains(.Saturday)
            sun = newValue.contains(.Sunday)
        }
    }
}

enum Day: String, CaseIterable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}
