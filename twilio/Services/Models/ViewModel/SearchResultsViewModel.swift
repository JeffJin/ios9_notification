//
//  SearchResultsViewModel.swift
//  ReactiveSwiftFlickrSearch
//
//  Created by Colin Eberhardt on 15/07/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

// A ViewModel that exposes the results of a Flickr search
@objc public class SearchResultsViewModel: NSObject {
  
  var searchResults: [SearchResultsItemViewModel]
  let title: String
  
  private let services: ViewModelServices
  
  init(services: ViewModelServices, searchResults: ScheduleSearchResults) {
    self.services = services
    self.title = searchResults.searchString
    self.searchResults = []//searchResults.appointments.map { SearchResultsItemViewModel(photo: $0, services: services ) }
    
    super.init()
  }
}