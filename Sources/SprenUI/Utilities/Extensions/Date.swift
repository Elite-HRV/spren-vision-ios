//
//  File.swift
//  
//
//  Created by Fernando on 10/3/22.
//

import Foundation

extension Date {
    var age: Int? { Calendar.current.dateComponents([.year], from: self, to: Date()).year }
}
