//
//  SyncPreference.swift
//  SyncPreference
//
//  Created by Harsh Choudhary on 1/20/20.
//

import Foundation

@objc(SyncPreference)
class SyncPreference: NSObject {
    
    @objc
    func constantsToExport() -> [String: Any]! {
        var map: [String: String] = [:]
        let defaults = UserDefaults.standard.dictionaryRepresentation()
        for entry in defaults {
            if let strType = entry.value as? String {
                map[entry.key] = strType
            }
        }
        let res: [String: Any] = ["InitialPrefs": map]
        return res
    }
    
    @objc
    func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc(clearMultiple:resolve:reject:)
    func clearMultiple(keys: [String], resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        for key in keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
        resolve(nil)
    }
    
    @objc(clearAll:reject:)
    func clearAll(resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        clearMultiple(keys: keys, resolve: resolve, reject: reject)
    }
    
    @objc(clear:resolve:reject:)
    func clear(key: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        UserDefaults.standard.removeObject(forKey: key)
        resolve(nil)
    }
    
    @objc(set:value:resolve:reject:)
    func set(key: String, value: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        UserDefaults.standard.set(value, forKey: key)
        resolve(nil)
    }
    
    @objc(setMultiple:resolve:reject:)
    func setMultiple(data: [String: String], resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        for entry in data {
            UserDefaults.standard.set(entry.value, forKey: entry.key)
        }
        resolve(nil)
    }
    
    
    
}
