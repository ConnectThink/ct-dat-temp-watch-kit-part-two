//
//  WeatherServiceProtocol.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/15/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import CoreLocation

protocol WeatherServiceProtocol {
    func retrieveTemperatureAtCoordinate(_ coordinate: CLLocationCoordinate2D, success: @escaping (Float) -> (), failure: @escaping (String) -> ())
}
