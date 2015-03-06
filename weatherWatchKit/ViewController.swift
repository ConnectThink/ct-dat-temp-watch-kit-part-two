//
//  ViewController.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/12/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Variables
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    
    private let weatherService: WeatherServiceProtocol = OpenWeatherMapWeatherService()
    
    private let datastore: DatastoreProtocol = SharedUserDefaultsDatastore()
    
    // MARK: -
    
    @IBAction func refreshButtonTouchUpInside(sender: AnyObject) {
        updateCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedTemperature: Int? = datastore.load(key:kTemperatureKey)
        if let temp = savedTemperature? {
            println("savedTemperature = \(temp)")
            temperatureLabel.text = "\(temp)"
        }
        else {
            temperatureLabel.text = "?"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCurrentLocation()
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
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
        
        let coordinate = manager.location.coordinate
        
        println("location = \(coordinate.latitude) \(coordinate.longitude)")
        
        updateTemperatureWithCoordinate(coordinate)
    }
    
    // MARK: - Temperature Handling
    
    private func updateTemperatureWithCoordinate(coordinate: CLLocationCoordinate2D) {
        weatherService.retrieveTemperatureAtCoordinate(coordinate,
            success: { (temp) -> () in
                let temperature = Int(temp)
                self.temperatureLabel.text = "\(temperature)"
                
                self.datastore.save(key: kTemperatureKey, value: temperature)
                self.datastore.commitToDisk()
            },
            failure: { (errorMessage) -> () in
                println(errorMessage)
        })
    }
}

