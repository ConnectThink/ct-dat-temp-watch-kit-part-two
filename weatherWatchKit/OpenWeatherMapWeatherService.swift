//
//  OpenWeatherMapWeatherService.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/15/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import AlamoFire
import CoreLocation
import SwiftyJSON

class OpenWeatherMapWeatherService: NSObject, WeatherServiceProtocol {
    
    private let rootApiUrl = "http://api.openweathermap.org/data/2.5"
    
    func retrieveTemperatureAtCoordinate(coordinate: CLLocationCoordinate2D, success: (Float) -> (), failure: (String) -> ()) {
        let url = "\(self.rootApiUrl)/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=imperial"
        
        Alamofire.request(.GET, url)
            .response { (request, response, data, error) in
                if (error != nil) {
                    println(error)
                    failure(error!.description)
                    return
                }
                
                if (data != nil) {
                    let jsonObject = JSON(data: data as NSData)
                    let temp = self.currentTemperatureFromJson(jsonObject)
                    success(temp)
                    return
                }
        }
    }
    
    private func currentTemperatureFromJson(json: JSON) -> Float {
        var ret: Float = 0.0
        
        if let weather = json["main"].dictionary {
            if let temp = weather["temp"]?.float {
                println("current temp = \(temp)")
                ret = temp
            }
        }
        
        return ret
    }
}
