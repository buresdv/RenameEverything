//
//  RenameEverythingApp.swift
//  Rename Everything
//
//  Created by David Bureš on 23.04.2024.
//

import Foundation

@main
struct RenameEverythingApp
{
    
    static var renamingType: RenamingType = .randomUUID
    
    static func main() async -> Void
    {
        print(ProcessInfo.terminalArguments)
        guard !ProcessInfo.terminalArguments.isEmpty else
        {
            print("No arguments passed")
            fatalError("No arguments passed")
        }
        
        do
        {
            self.renamingType = try parseRenamingType(arguments: &ProcessInfo.terminalArguments)
            
            print(self.renamingType.displayableRepresentation)
        }
        catch let renamingParsingError as RenamingParsingTypeError
        {
            switch renamingParsingError {
                case .couldNotParseRenamingType:
                    print("Renaming type declaration specified, but no renaming type was provided")
                case .noRenamingTypeSpecified:
                    print("Could not parse custom renaming type")
            }
        }
        catch
        {
            print("Parsing of arguments failed")
        }
    }
}

