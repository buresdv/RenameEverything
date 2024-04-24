//
//  Parse Renaming Type.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum RenamingParsingTypeError: Error
{
    case couldNotParseRenamingType, noRenamingTypeSpecified
}

func parseRenamingType(arguments: inout [String]) throws -> RenamingType
{
    guard let indexOfRenamingTypeDeclaration: Int = arguments.firstIndex(of: "--renameType") else
    {
        print("Renaming type declaration not specified - using Random UUID")
        return .randomUUID
    }
    
    guard let renamingTypeDeclaration: String = arguments[safe: indexOfRenamingTypeDeclaration + 1] else
    {
        throw RenamingParsingTypeError.noRenamingTypeSpecified
    }
    
    guard let definedRenamingType = RenamingType.fromString(renamingTypeDeclaration) else
    {
        throw RenamingParsingTypeError.couldNotParseRenamingType
    }
    
    return definedRenamingType
}
