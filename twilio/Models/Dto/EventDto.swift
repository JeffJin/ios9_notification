//
//  AppointmentDto.swift
//  AppointmentManagement
//
//  Created by Zhengyuan Jin on 2015-03-14.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

public class EventDto {
    var id:Int64
    var description:NSString
    var dateFrom:NSDate
    var dateTo:NSDate
    var imageLink:NSString = ""
    var note:NSString = ""
    
    init(id:Int64, desc:NSString, start:NSDate, end:NSDate){
        self.id = id
        self.description = desc
        self.dateFrom = start
        self.dateTo = end
    }
    
}
