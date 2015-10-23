//
//  AppointmentServiceImpl.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

public class EventServiceImpl : NSObject, EventService{
    
    var eventDac: EventDac!
    var eventNac: EventNac!
    //    var serviceUrl: String?
    //    var apiKey: String?
    
    override init(){
        super.init()
        eventDac = EventDacImpl(tableName: "Events")
        eventNac = EventNacImpl(connString: "link2.io/api")
    }
    
    public func getAppointments(userId:Int64, from:NSDate, to:NSDate) -> RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            let apptSignal:RACSignal = self.appointmentDac.getAppointments()
            apptSignal.subscribeNextAs {
                (results:[AppointmentDto]) -> () in
                if(results.count > 0){
                    subscriber.sendNext(results)
                    subscriber.sendCompleted()
                }
                else{
                    //TODO need to handle error resolve cases
                    self.appointmentNac.getAppointments(userId, dateFrom: from, dateTo: to).subscribeNextAs({(results:[AppointmentDto]) -> () in
                        self.appointmentDac.saveAppointments(results)
                        subscriber.sendNext(results)
                        subscriber.sendCompleted()
                    })
                }
            }
            
            return nil
        })
        
    }
    
    func findAppointments(results:[EventDto], keyword: String) -> [EventDto]{
        let filteredResults = results.filter{
            return $0.description.containsString(keyword) || $0.note.containsString(keyword)
        }
        return filteredResults
    }
    
    public func searchAppointments(userId:Int64, keywords:String) -> RACSignal{
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.appointmentDac.getAppointments().subscribeNextAs {(results:[AppointmentDto]) -> () in
                var dtos:[AppointmentDto] = []
                if(results.count > 0){
                    dtos = self.findAppointments(results, keyword: keywords)
                    subscriber.sendNext(dtos)
                }
                else{
                    //TODO need to handle error resolve cases
                    self.appointmentNac.getAppointments(userId, dateFrom: NSDate(), dateTo: NSDate()).subscribeNextAs{(results:[AppointmentDto]) -> () in
                        dtos = self.findAppointments(results, keyword: keywords)
                        subscriber.sendNext(dtos)
                    }
                }
                subscriber.sendCompleted()
            }
            return nil
        })
        
    }
    
    
    
    private func convertAppointment(dto: AppointmentDto) -> Event{
        return Appointment()
    }
    
    
    private func convertAppointments(dtos: [AppointmentDto]) -> [Event]{
        var temp = [Event]()
        for dto in dtos{
            temp.append(self.convertEvent(dto))
            
        }
        return temp
    }
    
    
    
    public func getEventDetails(id:Int64) -> RACSignal{
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            self.appointmentNac.getAppointmentDetails(id).subscribeNextAs{(result:EventDto?) -> Void in
                subscriber.sendNext(result!)
                subscriber.sendCompleted()
            }
            return nil
        })
    }
    
    
    public func getSelectedAppointment(apptId:Int64) -> RACSignal{
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.appointmentDac.getAppointmentDetails(apptId).subscribeNextAs {(result:AppointmentDto?) -> Void in
                if let temp = result{
                    subscriber.sendNext(temp)
                    subscriber.sendCompleted()
                }
                else{
                    subscriber.sendError(NSError())
                }
            }
            
            return nil
        })
    }

    private func convertToDto(appt:Event) -> EventDto{
        return EventDto(id: appt.id, desc: appt.desc as NSString, start: NSDate(timeIntervalSinceReferenceDate: appt.dateFrom), end: NSDate(timeIntervalSinceReferenceDate: appt.dateTo))
    }
    
    private func convertToDtos(appts:[Event]) -> [EventDto]{
        var apptDtos:[EventDto] = [EventDto]()
        //TODO change to map
        for appt in appts{
            var apptDto = convertToDto(appt)
            apptDtos.append(apptDto)
        }
        
        return apptDtos
    }
    
    
    public func saveSelectedAppointment(appt:EventDto) -> RACSignal{
        //TODO save selected one into core data
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            self.appointmentDac.saveSelectedAppointment(appt)
            subscriber.sendCompleted()
            return nil
        })
        
    }
    
}