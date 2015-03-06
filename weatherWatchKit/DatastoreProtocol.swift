//
//  DatastoreProtocol.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/19/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import Foundation

let kCoordinateLatKey = "kCoordinateLatKey"
let kCoordinateLonKey = "kCoordinateLonKey"
let kTemperatureKey   = "kTemperatureKey"

protocol DatastoreProtocol {
    func save(#key: String, value: NSObject)
    func load<T>(#key: String) -> T?
    func commitToDisk()
}
