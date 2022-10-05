//
//  TimeInfo.swift
//  SprenInternal
//
//  Created by Keith Carolus on 7/14/22.
//

import Foundation

struct TimeInfo: Encodable {
    
    let imageTime: String
    var timezoneAbbreviation: String?
    let timezoneID: String
    var regionCode: String?
    
    init() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        imageTime = formatter.string(from: Date())
        
        if let timezoneAbbreviation = TimeZone.current.abbreviation() {
            self.timezoneAbbreviation = timezoneAbbreviation
        }
        
        self.timezoneID = TimeZone.current.identifier
        
        if let regionCode = Locale.current.regionCode {
            self.regionCode = regionCode
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case imageTime = "imageTime"
        case timezoneAbbreviation = "timezoneAbbreviation"
        case timezoneID = "timezoneId"
        case regionCode = "regionCode"
    }
    
}
