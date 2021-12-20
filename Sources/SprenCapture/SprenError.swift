//
//  SprenError.swift
//  
//
//  Created by nick on 17.12.2021.
//

import Foundation

enum SprenError: Error {
    case noCameraDetected
    case noCameraFormatDetected
    case deviceInputConfigurationError
    case sessionInputOutputConfigurationError
    
    var localizedDescription: String {
        switch self {
        case .noCameraDetected:
            return "There are no suitable camera detected"
        case .noCameraFormatDetected:
            return "There are no suitable camera format detected"
        case .deviceInputConfigurationError:
            return "Cant setup AVCaptureDeviceInput with video device specified"
        case .sessionInputOutputConfigurationError:
            return "Cannot setup input or output into camera session"
        default:
            return "Unknown Error"
        }
    }
}
