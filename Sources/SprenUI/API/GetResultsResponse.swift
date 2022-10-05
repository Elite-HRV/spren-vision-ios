//
//  GetResultsResponse.swift
//  SprenUI
//
//  Created by Keith Carolus on 2/11/22.
//

import Foundation

struct StatusValue: Decodable {
    
    enum Status: String, Decodable {
        case pending
        case complete
        case error
    }
    
    let status: Status
    let value: Double?
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case value
        case errorDescription
    }
    
    var complete: Bool {
        status == .complete
    }
    var error: Bool {
        status == .error
    }
}

struct Biomarkers: Decodable {
    let hr: StatusValue
    let hrvScore: StatusValue
    let rmssd: StatusValue
    let breathingRate: StatusValue
    
    enum CodingKeys: String, CodingKey {
        case hr
        case hrvScore
        case rmssd
        case breathingRate
    }
    
    var complete: Bool {
        hr.complete && hrvScore.complete && rmssd.complete && breathingRate.complete
    }
    var error: Bool {
        hr.error || hrvScore.error || rmssd.error || breathingRate.error
    }
}

struct Insights: Decodable {
    let readiness: StatusValue
    let ansBalance: StatusValue
    
    enum CodingKeys: String, CodingKey {
        case readiness
        case ansBalance
    }
    
    var complete: Bool {
        readiness.complete && ansBalance.complete
    }
    var error: Bool {
        readiness.error || ansBalance.error
    }
}

struct GetResultsResponse: Decodable {
        
    let biomarkers: Biomarkers
    let insights: Insights
    let signalQuality: StatusValue
        
    func isComplete() -> Bool {
        return biomarkers.complete && insights.complete && signalQuality.complete
    }
    
    func hasError() -> Bool {
        return biomarkers.error || insights.error || signalQuality.error
    }
    
    func toResults(guid: String) -> Results? {
        guard let hr = biomarkers.hr.value,
              let hrvScore = biomarkers.hrvScore.value,
              let rmssd = biomarkers.rmssd.value,
              let breathingRate = biomarkers.breathingRate.value,
              let signalQuality = signalQuality.value else {
            return nil
        }
        
        return Results(guid: guid,
                       hr: hr,
                       hrvScore: hrvScore,
                       rmssd: rmssd,
                       breathingRate: breathingRate,
                       readiness: insights.readiness.value,
                       ansBalance: insights.ansBalance.value,
                       signalQuality: signalQuality)
    }
    
}

public struct Results {
    let guid: String
    let hr: Double
    let hrvScore: Double
    let rmssd: Double
    let breathingRate: Double
    
    // require 2 readings on 2 separate days within 10 days or value will be null
    let readiness: Double?
    let ansBalance: Double?
    
    let signalQuality: Double
    
    static let empty = Results(guid: "", hr: 0, hrvScore: 0, rmssd: 0, breathingRate: 0, readiness: 0, ansBalance: 0, signalQuality: 0)
}
