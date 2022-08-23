//
//  GetResultsResponse.swift
//  SprenInternal
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
}

struct Biomarkers: Decodable {
    let hr: StatusValue
    let hrvScore: StatusValue
}

struct Insights: Decodable {
    let readiness: StatusValue
}

struct GetResultsResponse: Decodable {
        
    let biomarkers: Biomarkers
    let insights: Insights
    let signalQuality: StatusValue
        
    func isComplete() -> Bool {
        return biomarkers.hr.status == .complete && biomarkers.hrvScore.status == .complete
    }
    
    func hasError() -> Bool {
        return biomarkers.hr.status == .error || biomarkers.hrvScore.status == .error
    }
    
}
