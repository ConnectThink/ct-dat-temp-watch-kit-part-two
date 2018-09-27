//
//  InterfaceController.swift
//  weatherWatchKit watchOS App Extension
//
//  Created by Matt Lathrop on 9/25/18.
//  Copyright © 2018 Connect Think. All rights reserved.
//

import Foundation
import WatchConnectivity
import WatchKit

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    let datastore: DatastoreProtocol = SharedUserDefaultsDatastore()
    var session: WCSession?
    
    // UI
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let savedTemperature: Int? = datastore.load(key: kTemperatureKey)
        if let temp = savedTemperature {
            print("savedTemperature = \(temp)")
            temperatureLabel.setText("\(temp)")
        }
        else {
            temperatureLabel.setText("?")
        }
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        loadTemperatureFromApplicationContext()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func loadTemperatureFromApplicationContext() {
        if let applicationContext = session?.receivedApplicationContext {
            if let savedTemperature = applicationContext[kTemperatureKey] as? Int {
                print("\(savedTemperature)")
                
                self.datastore.save(key: kTemperatureKey, value: savedTemperature as NSObject)
                self.datastore.commitToDisk()
                
                DispatchQueue.main.async {
                    self.temperatureLabel.setText("\(savedTemperature)")
                }
            }
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
}
