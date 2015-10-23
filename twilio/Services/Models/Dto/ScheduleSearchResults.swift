//
//  ScheduleSearchResults.swift
//  AppointmentManagement
//
//  Created by Zhengyuan Jin on 2015-05-30.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

import Foundation

// Represents the result of a Flickr search
class ScheduleSearchResults {
    let searchString: String
    let totalResults: Int
    let appointments: [EventDto]
    
    init(searchString: String, totalResults: Int, appointments: [EventDto]) {
        self.searchString = searchString;
        self.totalResults = totalResults
        self.appointments = appointments
    }
}
