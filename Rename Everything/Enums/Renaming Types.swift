//
//  Renaming Types.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum RenamingType: String, CaseIterable, CustomStringConvertible
{
    case randomUUID
    case randomWord

    var description: String
    {
        return rawValue
    }
    
    var displayableRepresentation: String
    {
        switch self {
            case .randomUUID:
                return "Random UUID"
            case .randomWord:
                return "Random Words"
        }
    }

    static func fromString(_ string: String) -> RenamingType?
    {
        return RenamingType.allCases.first { $0.description == string }
    }
}
