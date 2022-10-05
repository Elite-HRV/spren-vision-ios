//
//  Configuration.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 06/01/22.
//

import Foundation

//let ENV      = "dev"
//let API_URL  = "https://gczw0qnqsk.execute-api.us-west-2.amazonaws.com/dev"
//let API_KEY  = "f6c28d98-6395-4ada-92dd-20b09d080425"

#if DEV
let ENV      = "dev"
let API_URL  = "https://pl63c7bat5.execute-api.us-west-2.amazonaws.com/dev"
let API_KEY  = "052960e7-9772-443b-b825-148edaf838ef"
#endif
#if QA
let ENV      = "qa"
let API_URL  = "https://qa.api.spren.com"
let API_KEY  = "3bd327b7-fc65-45e5-ae06-38cbb6427eae"
#endif
#if TEST
let ENV      = "test"
let API_URL  = "https://test.api.spren.com"
let API_KEY  = "8872f755-0c47-445d-915d-6b61600c5b43"
#endif
#if PROD
let ENV      = "prod"
let API_URL  = "https://prod.api.spren.com"
let API_KEY  = "2dd0efe5-a50b-450b-9826-859beb9d2604"
#endif

class Config {
    static let env    = ENV
    static let apiURL = API_URL
    static let apiKey = API_KEY
    
    static let bundleId = getBundleId()
    static var deviceIdentifierKey: String {
        "\(bundleId).device-identifier"
    }
    static let deviceIdentifier = getDeviceIdentifier()

    fileprivate static func getDeviceIdentifier() -> String {
        guard let identifier = UserDefaults.standard.string(forKey: deviceIdentifierKey) else {
            let newIdentifier = UUID().uuidString
            UserDefaults.standard.set(newIdentifier, forKey: deviceIdentifierKey)
            writeOut(deviceIdentifier: newIdentifier)
            return newIdentifier
        }
        return identifier
    }

    fileprivate static func getBundleId() -> String {
        guard let info = Bundle.main.infoDictionary else { return "Unknown" }
        let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"

        return bundle
    }
    
    fileprivate static func writeOut(deviceIdentifier: String) {
        guard let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[safe: 0] else {
            return
        }
        let url = documentsDir.appendingPathComponent("deviceIdentifier.txt")
        
        if FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.removeItem(atPath: url.path)
            } catch {
                print("unable to delete")
                return
            }
        }
        
        do {
            try deviceIdentifier.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("unable to write")
            return
        }
    }

}
