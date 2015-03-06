//
//  InterfaceController.swift
//  weatherWatchKit WatchKit Extension
//
//  Created by Matthew Lathrop on 1/19/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    
    let datastore: DatastoreProtocol = SharedUserDefaultsDatastore()
    
    func loadTemperatureFromDatastore() {
        let savedTemperature: Int? = datastore.load(key:kTemperatureKey)
        if let temp = savedTemperature? {
            println("\(temp)")
            temperatureLabel.setText("\(temp)")
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        loadTemperatureFromDatastore()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
