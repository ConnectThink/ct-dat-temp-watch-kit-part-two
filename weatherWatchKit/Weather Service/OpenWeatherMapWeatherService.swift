//
//  OpenWeatherMapWeatherService.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/15/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import Alamofire
import CoreLocation
import SwiftyJSON

class OpenWeatherMapWeatherService: NSObject, WeatherServiceProtocol {
    
    private let rootApiUrl = "https://api.openweathermap.org/data/2.5"
    
    func retrieveTemperatureAtCoordinate(_ coordinate: CLLocationCoordinate2D, success: @escaping (Float) -> (), failure: @escaping (String) -> ()) {
        let url = "\(self.rootApiUrl)/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=imperial&appid=cefe9f6a278ac1a382025f5f5776a434"
        
        Alamofire.request(url).responseJSON { response in
            if let error = response.error {
                print(error)
                failure(error.localizedDescription)
                return
            }
            
            if let data = response.data {
                let jsonObject = try! JSON(data: data)
                let temp = self.currentTemperatureFromJson(jsonObject)
                success(temp)
                return
            }
        }
    }
    
    private func currentTemperatureFromJson(_ json: JSON) -> Float {
        var ret: Float = 0.0
        
        if let weather = json["main"].dictionary {
            if let temp = weather["temp"]?.float {
                print("current temp = \(temp)")
                ret = temp
            }
        }
        
        return ret
    }
}
