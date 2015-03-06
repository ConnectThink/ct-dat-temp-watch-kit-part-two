//
//  SharedUserDefaultsDatastore.swift
//  weatherWatchKit
//
//  Created by Matthew Lathrop on 1/19/15.
//  Copyright (c) 2015 Connect Think. All rights reserved.
//

import Foundation

class SharedUserDefaultsDatastore: NSObject, DatastoreProtocol {
    let userDefaults = NSUserDefaults(suiteName: "group.connectthink.weatherWatchKit")!
    
    func save(#key: String, value: NSObject) {
        userDefaults.setObject(value, forKey: key)
    }
    
    func load<T>(#key: String) -> T? {
        let obj: AnyObject? = userDefaults.objectForKey(key)
        
        if let validObj = obj as? T {
            return validObj
        }
        else {
            return nil
        }
    }
    
    func commitToDisk() {
        userDefaults.synchronize()
    }
}
