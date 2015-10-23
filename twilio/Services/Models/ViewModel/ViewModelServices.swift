//
//  ViewModelServices.swift
//

import Foundation

// provides common services to view models
@objc public protocol ViewModelServices {
    
    // pushes the given ViewMolde onto the stack, this causes the UI to navigate from
    // one view to the next
    func pushViewModel(viewModel:AnyObject)
    
    // provides the search API
    var eventService: EventService { get }
    
    //var twilioService: TwilioService{ get }
    
    //var accountService: AccountService { get }
}