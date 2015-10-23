//
//  AppointmentDac.swift
//  appointment core data access logic
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//
import Foundation

public protocol AppointmentDac {
    func getAppointments() -> RACSignal
    func getAppointmentDetails(id:Int64) -> RACSignal
    func saveSelectedAppointment(appt:AppointmentDto) -> RACSignal
    func saveAppointments(appts:[AppointmentDto]) -> RACSignal
}