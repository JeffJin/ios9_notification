//
//  TodoItem.swift
//  twilio
//
//  Created by Zhengyuan Jin on 2015-11-07.
//  Copyright © 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

struct TodoItem {
    var title: String
    var deadline: NSDate
    var UUID: String
    
    init(deadline: NSDate, title: String, UUID: String) {
        self.deadline = deadline
        self.title = title
        self.UUID = UUID
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending) // deadline is earlier than current date
    }
}