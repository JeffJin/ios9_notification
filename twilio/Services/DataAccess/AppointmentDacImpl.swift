//
//  AppointmentDacImpl.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation
import CoreData


public class AppointmentDacImpl : AppointmentDac{
    var tableName:String!
    
    public init(tableName: String) {
        self.tableName = tableName
        //initAppointments()
    }
    
    func queryForAppointments() -> Array<AppointmentDto>{
        var dtos = Array<AppointmentDto>()
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: tableName)
        
        request.returnsObjectsAsFaults = false
        
        let results = context.executeFetchRequest(request, error: nil) as! [Appointment]?
        
        if results!.count > 0 {
            for appt: Appointment in results! {
                let dto = AppointmentDto(id: appt.id, desc: appt.desc, start: NSDate(timeIntervalSince1970: appt.dateFrom), end: NSDate(timeIntervalSince1970: appt.dateTo))
                dto.imageLink = appt.url
                dto.note = appt.note
                
                dtos.append(dto)
            }
        }
        return dtos
    }
    
    //return a promise to resolve appointments
    //filter by start time and end time
    public func getAppointments() -> RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            var results = self.queryForAppointments()
            subscriber.sendNext(results)
            subscriber.sendCompleted()
            
            return nil
        })
    }
    
    //return a promise to resolce appointment details, if not already in cache
    public func getAppointmentDetails(id:Int64) -> RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            var results = self.queryForAppointments()
            var selected = results.filter({ (dto) -> Bool in
                return dto.id == id
            })
            if(selected.count > 0){
                subscriber.sendNext(selected.first)
                subscriber.sendCompleted()
            }
            else{
                subscriber.sendError(NSError())
            }            
            return nil
        })
    }
    
    public func saveSelectedAppointment(appt:AppointmentDto) -> RACSignal{
        //TODO save selected one into core data
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            subscriber.sendCompleted()
            
            return nil
        })
        
        
    }
    
    func currentTimeMillis() -> Int64{
        var nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000) + Int64(nowDouble/1000)
    }
    
    func persistAppointments(appts:[AppointmentDto]){
        //TODO save into core data
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        for dto in appts{
            println("Saving \(dto.description) \(dto.id)")
            var temp = NSEntityDescription.insertNewObjectForEntityForName(tableName, inManagedObjectContext: context) as! Appointment
            temp.id = currentTimeMillis()
            temp.createOn = dto.dateFrom.timeIntervalSince1970
            temp.updateOn = dto.dateFrom.timeIntervalSince1970
            temp.dateFrom = dto.dateFrom.timeIntervalSince1970
            temp.dateTo = dto.dateTo.timeIntervalSince1970
            temp.desc = dto.description as! String
            temp.note = dto.note as! String
            temp.url = dto.imageLink as! String
        }
        
        context.save(nil)
    }
    
    public func saveAppointments(appts:[AppointmentDto]) -> RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.persistAppointments(appts)
            subscriber.sendCompleted()
            
            return nil
        })
    }
    
}