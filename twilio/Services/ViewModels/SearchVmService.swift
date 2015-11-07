//
//  File.swift
//  twilio
//
//  Created by Zhengyuan Jin on 2015-11-06.
//  Copyright © 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

public class SearchVmService {
    

    let eventNac:EventNac = EventNacImpl(connString: "link2.io/api")

    public func setupTextInput(textField: UITextField){
       
        let searchStrings = textField.rac_textSignal()
             .toSignalProducer()
             .map { text in text as! String }
    
        let searchResults = searchStrings
            .flatMap(.Latest) { (query: String) -> SignalProducer<[EventDto], NSError> in
                 return self.eventNac.search(query)
            }
            .map { (events) -> [EventDto] in
                return events
            }
            .observeOn(UIScheduler())
    
        searchResults.startWithNext { results in
            for r in results{
                 print("Search results: \(r.description)")
            }
        
        }
    }
}
