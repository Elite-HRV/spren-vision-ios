//
//  CaseIterable+Index.swift
//  SprenInternal
//
//  Created by nick on 09.08.2022.
//

import Foundation

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.index { self == $0 }
    }
}
