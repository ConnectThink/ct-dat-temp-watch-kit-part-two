//
//  SharedUserDefaultsDatastore.swift
//  weatherWatchKit
//
//  Created by Matt Lathrop on 9/25/18.
//  Copyright © 2018 Connect Think. All rights reserved.
//

import Foundation

class SharedUserDefaultsDatastore: NSObject, DatastoreProtocol {
    let userDefaults = UserDefaults(suiteName: "group.connectthink.weatherWatchKit")!
    
    func save(key: String, value: NSObject) {
        userDefaults.set(value, forKey: key)
    }
    
    func load<T>(key: String) -> T? {
        let obj: Any? = userDefaults.object(forKey: key)
        
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
