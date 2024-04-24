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
        guard !ProcessInfo.terminalArguments.isEmpty else
        {
            print(String.helpText)
            print("Hello I should be red with a yellow background".color(.greenBright).font([.bold, .italic]))
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
            
            print(ProcessInfo.terminalArguments)
            
            print("Will use \"\(self.renamingType.displayableRepresentation)\" as renaming type")
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

