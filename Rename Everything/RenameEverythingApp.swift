//
//  RenameEverythingApp.swift
//  Rename Everything
//
//  Created by David Bureš on 23.04.2024.
//

import Foundation
import SwiftyTerminalColors

@main
struct RenameEverythingApp
{
    
    static var renamingType: RenamingType = .randomUUID
    
    static func main() async -> Void
    {
        guard !ProcessInfo.terminalArguments.isEmpty else
        {
            print(String.helpText)
            return
        }
        
        guard ProcessInfo.terminalArguments.filter({ $0 == "--help" }).isEmpty else
        {
            print(String.helpText)
            return
        }
        
        do
        {
            self.renamingType = try parseRenamingType(arguments: &ProcessInfo.terminalArguments)
            
            writeLine("Will use \"\(self.renamingType.displayableRepresentation)\" as renaming type", lineStyle: .info)
        }
        catch let renamingParsingError as RenamingParsingTypeError
        {
            switch renamingParsingError {
                case .couldNotParseRenamingType:
                    writeLine("Renaming type declaration specified, but no renaming type was provided", lineStyle: .error)
                case .noRenamingTypeSpecified:
                    writeLine("Could not parse custom renaming type", lineStyle: .error)
            }
        }
        catch
        {
            writeLine("Parsing of arguments failed", lineStyle: .error)
        }
    }
}

