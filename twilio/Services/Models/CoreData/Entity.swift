//
//  Entity.swift
//  
//
//  Created by Zhengyuan Jin on 2015-03-22.
//
//

import Foundation
import CoreData

public class Entity: NSManagedObject {
  
    @NSManaged var createOn: NSTimeInterval
    @NSManaged var id: Int64
    @NSManaged var updateOn: NSTimeInterval

}
