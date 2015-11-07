//
//  TodoList.swift
//  twilio
//
//  Created by Zhengyuan Jin on 2015-11-07.
//  Copyright © 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation
import UIKit

class TodoList {
    class var instance : TodoList {
        
        struct Static {
            static let sharedInstance : TodoList = TodoList()
        }
        return Static.sharedInstance
    }
    
    private let ITEMS_KEY = "todoItems"
    
    func addItem(item: TodoItem) { // persist a representation of this todo item in NSUserDefaults
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        
        todoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        let notification = createLocalNotification("Todo Item \"\(item.title)\" Is Overdue", fireDate: item.deadline, uid: item.UUID)
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func createLocalNotification(body:String, fireDate:NSDate, uid:String)->UILocalNotification{
        let notification = UILocalNotification()
        notification.alertBody = body // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = fireDate // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": uid, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        return notification
    }
    
    func removeItem(item: TodoItem) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        
        if var todoItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            todoItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: ITEMS_KEY) // save/overwrite todo item list
        }
    }
    
    func allItems() -> [TodoItem] {
        let todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        return items.map({TodoItem(deadline: $0["deadline"] as! NSDate, title: $0["title"] as! String, UUID: $0["UUID"] as! String!)})
        
//            .sorted({(left: TodoItem, right:TodoItem) -> Bool in
//                (left.deadline.compare(right.deadline) == .OrderedAscending)
//            })

    }
}