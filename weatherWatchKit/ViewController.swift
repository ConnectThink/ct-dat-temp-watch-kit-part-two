//
//  ViewController.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/12/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import CoreLocation
import UIKit
import WatchConnectivity

class ViewController: UIViewController, CLLocationManagerDelegate, WCSessionDelegate {
    
    // MARK: - UI
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Variables
    
    let locationManager = CLLocationManager()
    
    let weatherService: WeatherServiceProtocol = OpenWeatherMapWeatherService()
    
    let datastore: DatastoreProtocol = SharedUserDefaultsDatastore()
    
    var session: WCSession?
    
    // MARK: -
    
    @IBAction func refreshButtonTouchUpInside(_ sender: AnyObject) {
        updateCurrentLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedTemperature: Int? = datastore.load(key: kTemperatureKey)
        if let temp = savedTemperature {
            print("savedTemperature = \(temp)")
            temperatureLabel.text = "\(temp)"
        }
        else {
            temperatureLabel.text = "?"
        }
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    // MARK: - Location Handling
    
    private func updateCurrentLocation() {
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        if let coordinate = manager.location?.coordinate {
            print("location = \(coordinate.latitude) \(coordinate.longitude)")
            updateTemperatureWithCoordinate(coordinate)
        }
    }
    
    // MARK: Temperture Handling
    
    private func updateTemperatureWithCoordinate(_ coordinate: CLLocationCoordinate2D) {
        weatherService.retrieveTemperatureAtCoordinate(coordinate,
            success: { (temp) -> () in
                let temperature = Int(temp)
                self.temperatureLabel.text = "\(temperature)"
                self.datastore.save(key: kTemperatureKey, value: temperature as NSObject)
                self.datastore.commitToDisk()
                
                let applicationContext = [ kTemperatureKey : temperature ]
                try! self.session?.updateApplicationContext(applicationContext)
            },
            failure: { (errorMessage) -> () in
                print(errorMessage)
        })
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
}

