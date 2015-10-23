//
//  SearchResultsItemViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 18/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// A ViewModel that backs an individual photo in a search result view.
@objc  public class SearchResultsItemViewModel: NSObject {
    
    dynamic var isVisible: Bool
    let title: String
    let imageUrl: NSURL
    var id: Int64
    var note: String
    
    private let services: ViewModelServices
    
    init(appointment: AppointmentDto, services: ViewModelServices) {
        self.services = services
        title = appointment.description as String
        imageUrl = NSURL(fileURLWithPath: appointment.imageLink as! String)!
        id = appointment.id
        isVisible = false
        note = appointment.note as String
        
        super.init()
        
        // a signal that emits events when visibility changes
        let visibleStateChanged = RACObserve(self, "isVisible").skip(1)
        
        // filtered into visible and hidden signals
        let visibleSignal = visibleStateChanged.filter { $0.boolValue }
        let hiddenSignal = visibleStateChanged.filter { !$0.boolValue }
        
        // a signal that emits when an item has been visible for 1 second
        let fetchMetadata = visibleSignal.delay(1).takeUntil(hiddenSignal)
        
        fetchMetadata.subscribeNext {
            (next: AnyObject!) -> () in
            self.services.appointmentService.searchAppointments(123456, keywords:"keywords").subscribeNextAs {
                (appts: [AppointmentDto]) -> () in
        
            }
        }
        
    }
    
}
