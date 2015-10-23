//
//  ViewController.swift
//  twilio
//
//  Created by Zhengyuan Jin on 2015-10-23.
//  Copyright © 2015 eWorkspace Solutions Inc. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var inProgressBar: UIProgressView!
    @IBOutlet weak var resultLabel: UILabel!
    
    let eventNac:EventNac = EventNacImpl(connString: "link2.io/api")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setup(){
        
        let searchStrings = searchTextField.rac_textSignal()
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

