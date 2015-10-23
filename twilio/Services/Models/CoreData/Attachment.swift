//
//  Attachment.swift
//  
//
//  Created by Zhengyuan Jin on 2015-03-22.
//
//

import Foundation
import CoreData

public class Attachment: Entity {

    @NSManaged var fileName: String
    @NSManaged var fileType: String
    @NSManaged var fileUrl: String
    @NSManaged var referenceId: String

}
