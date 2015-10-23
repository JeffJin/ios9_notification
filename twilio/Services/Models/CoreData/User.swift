//
//  User.swift
//  
//
//  Created by Zhengyuan Jin on 2015-03-22.
//
//

import Foundation
import CoreData

public class User: Entity {

    @NSManaged var dob: NSTimeInterval
    @NSManaged var email: String
    @NSManaged var externalId: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var appointments: NSSet

}
