//
//  SprenError.swift
//  
//
//  Created by nick on 17.12.2021.
//

import Foundation

enum SprenCaptureError: Error {
    case noCameraDetected
    case noCameraFormatDetected
    case deviceInputConfigurationError
    case sessionInputOutputConfigurationError

    var localizedDescription: String {
        switch self {
        case .noCameraDetected:
            return "No suitable camera detected"
        case .noCameraFormatDetected:
            return "No suitable camera format detected"
        case .deviceInputConfigurationError:
            return "Cannot setup AVCaptureDeviceInput with video device specified"
        case .sessionInputOutputConfigurationError:
            return "Cannot setup input or output into camera session"
        }
    }
}
