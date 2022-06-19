//
//  Technique.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation

enum Technique: String, CaseIterable {
    case RAUSIS
    case FILD
    case MILD
    case SSILD
    case WILD
}

extension Technique {
    var description: String {
        switch self {
        case .RAUSIS:
            return "Uses multiple chained Alarms to induce Lucid Dreams"
        case .FILD:
            return "Finger Induced Lucid Dream"
        case .MILD:
            return "Mnemonic Induced Lucid Dream"
        case .SSILD:
            return "Senses Initiated Lucid Dream"
        case .WILD:
            return "Wake Initiated Lucid Dream"
        }
    }
}
