//
//  Appointment.swift
//  AppointmentManagement
//
//  Created by Zhengyuan Jin on 2015-03-14.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

@objc public class EventListViewModel : NSObject {
    let defaultImage: NSString = "default-no-image.png"
    
    //MARK: Properties
    
    dynamic var searchText = ""
    dynamic var previousSearches: [PreviousSearchViewModel]
    var executeSearch: RACCommand!
    let title = "Event Search"
    var previousSearchSelected: RACCommand!
    var connectionErrors: RACSignal!
    
    private let services: ViewModelServices
    
    //MARK: Public APIprintln
    
    init(services: ViewModelServices) {
        
        self.services = services
        self.previousSearches = []
        
        super.init()
        
        setupRac()
    }
    
    func setupRac(){
        var validSearchSignal = RACObserve(self, "searchText").mapAs {
            (text: NSString) -> NSNumber in
            return text.length > 3
            }.distinctUntilChanged();
        
        executeSearch = RACCommand(enabled: validSearchSignal) {
            (any:AnyObject!) -> RACSignal in
            return self.executeSearchSignal()
        }
        
        connectionErrors = executeSearch!.errors
        
        previousSearchSelected = RACCommand() {
            (any:AnyObject!) -> RACSignal in
            let previousSearch = any as! PreviousSearchViewModel
            self.searchText = previousSearch.searchString
            return self.executeSearchSignal()
        }
    }
    
    //MARK: Private methods
    
    private func executeSearchSignal() -> RACSignal {
        return services.appointmentService.searchAppointments(123456, keywords: "soccer").doNextAs {
            (results: ScheduleSearchResults) -> () in
            let viewModel = SearchResultsViewModel(services: self.services, searchResults: results)
            self.services.pushViewModel(viewModel)
            self.addToSearchHistory(results)
        }
    }
    
    private func addToSearchHistory(result: ScheduleSearchResults) {
        let matches = previousSearches.filter { $0.searchString == self.searchText }
        
        var previousSearchesUpdated = previousSearches
        
        if matches.count > 0 {
            let match = matches[0]
            var withoutMatch = previousSearchesUpdated.filter { $0.searchString != self.searchText }
            withoutMatch.insert(match, atIndex: 0)
            previousSearchesUpdated = withoutMatch
        } else {
            let previousSearch = PreviousSearchViewModel(searchString: searchText, totalResults: result.totalResults, thumbnail: NSURL(fileURLWithPath: result.events[0].imageLink as! String)!)
            previousSearchesUpdated.insert(previousSearch, atIndex: 0)
        }
        
        if (previousSearchesUpdated.count > 10) {
            previousSearchesUpdated.removeLast()
        }
        
        previousSearches = previousSearchesUpdated
    }
    
    public func getImage(imageLink:String) -> UIImage{
        if(imageLink != ""){
            var url: NSURL = NSURL(string:  imageLink)!
            var imageData = NSData(contentsOfURL: url)!
            return UIImage(data: imageData)!
        }
        else{
            return UIImage(named: self.defaultImage as String)!
        }
    }
    
    
}

