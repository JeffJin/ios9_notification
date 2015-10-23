//
//  Location.swift
//  
//
//  Created by Zhengyuan Jin on 2015-03-22.
//
//

import Foundation
import CoreData

public class Location: Entity {

    @NSManaged var address: String
    @NSManaged var city: String
    @NSManaged var country: String
    @NSManaged var latitude: NSDecimalNumber
    @NSManaged var longitude: NSDecimalNumber
    @NSManaged var state: String

}
