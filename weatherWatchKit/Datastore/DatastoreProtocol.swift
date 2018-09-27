//
//  DatastoreProtocol.swift
//  weatherWatchKit
//
//  Created by Matt Lathrop on 9/25/18.
//  Copyright © 2018 Connect Think. All rights reserved.
//

import Foundation

let kCoordinateLatKey = "kCoordinateLatKey"
let kCoordinateLonKey = "kCoordinateLonKey"
let kTemperatureKey   = "kTemperatureKey"

protocol DatastoreProtocol {
    func save(key: String, value: NSObject)
    func load<T>(key: String) -> T?
    func commitToDisk()
}
