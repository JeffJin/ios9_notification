//
//  AppointmentDacImpl.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation
import ReactiveCocoa

public class EventNacImpl : EventNac{
    var connectionString:String!
    
    public required init(connString: String) {
        self.connectionString = connString
    }
    
    public init(){
        
    }

    public func search(keyword:String) -> SignalProducer<[EventDto], NSError>{
        let dto1 = EventDto(id: 111, desc: "desc1", start: NSDate(), end: NSDate())
        let dto2 = EventDto(id: 112, desc: "desc2", start: NSDate(), end: NSDate())
        let dto3 = EventDto(id: 113, desc: "desc5", start: NSDate(), end: NSDate())
        let dto4 = EventDto(id: 115, desc: "desc6", start: NSDate(), end: NSDate())
        let dto5 = EventDto(id: 116, desc: "desc7", start: NSDate(), end: NSDate())
        
        var dtos:[EventDto] = []
        dtos.append(dto1)
        dtos.append(dto2)
        dtos.append(dto3)
        dtos.append(dto4)
        dtos.append(dto5)
        
        
        return SignalProducer<[EventDto], NSError>.init(value: dtos)
    }
}