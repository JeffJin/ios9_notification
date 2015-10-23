//
//  AppointmentDac.swift
//  appointment web service access logic
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//
import Foundation
import ReactiveCocoa

public protocol EventNac {
    init(connString:String)
    func search(keyword: String) -> SignalProducer<[EventDto], NSError>
}