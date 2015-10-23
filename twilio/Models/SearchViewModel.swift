//
//  AppointmentSearchViewModel.swift
//  AppointmentManagement
//
//  Created by Zhengyuan Jin on 2015-06-01.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation

// The top-level ViewModel, exposes an interface that allows you
// to search appointment api via a search string It also displays the
// history of recent searches
@objc public class SearchViewModel: NSObject {
    
    //MARK: Properties
    
    dynamic var searchText = ""
    dynamic var previousSearches: [PreviousSearchViewModel]
    var executeSearch: RACCommand!
    let title = "Search"
    var previousSearchSelected: RACCommand!
    var connectionErrors: RACSignal!
    
    let services: ViewModelServices
    
    //MARK: Public APIprintln
    
    init(viewModel: ViewModelServices) {
        
        self.services = viewModel
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
        return services.appointmentService.searchAppointments(123456, keywords: self.searchText).doNextAs {
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
            let previousSearch = PreviousSearchViewModel(searchString: searchText, totalResults: result.totalResults, thumbnail:  NSURL(fileURLWithPath: result.appointments[0].imageLink as! String)!)
            previousSearchesUpdated.insert(previousSearch, atIndex: 0)
        }
        
        if (previousSearchesUpdated.count > 10) {
            previousSearchesUpdated.removeLast()
        }
        
        previousSearches = previousSearchesUpdated
    }
    
}
