//
//  AppointmentService.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

@objc public protocol EventService {
    func getEventDetails(id:Int64) -> RACSignal
    func saveEvent(appt:EventDto) -> RACSignal
    func searchEvents(userId: Int64, from:NSDate, to:NSDate, keywords:String) -> RACSignal
}