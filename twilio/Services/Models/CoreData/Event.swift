//
//  Appointment.swift
//  
//
//  Created by Zhengyuan Jin on 2015-03-22.
//
//

import Foundation
import CoreData

public class Event: Entity {
    @NSManaged var dateFrom: NSTimeInterval
    @NSManaged var dateTo: NSTimeInterval
    @NSManaged var desc: String
    @NSManaged var note: String
    @NSManaged var url: String
    @NSManaged var attachments: NSSet
    @NSManaged var attendees: NSSet
    @NSManaged var followup: Event
    @NSManaged var location: Location

}
