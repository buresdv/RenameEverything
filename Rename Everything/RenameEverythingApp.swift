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
        
        /// Enable debug mode if the user wants it
        if !ProcessInfo.terminalArguments.filter({ $0 == "--debug" }).isEmpty
        {
            AppGlobals.shared.isDebugModeEnabled = true
            
            guard let indexOfDebugFlag = ProcessInfo.terminalArguments.firstIndex(of: "--debug") else
            {
                writeLine("Could not parse arguments: Could not find debug flag index", lineStyle: .error)
                return
            }
            
            ProcessInfo.terminalArguments.remove(at: indexOfDebugFlag)
            
            writeLine(ProcessInfo.terminalArguments, lineStyle: .debug)
        }
        
        do
        {
            self.renamingType = try parseRenamingType(arguments: &ProcessInfo.terminalArguments)
            
            writeLine("Will use \"\(self.renamingType.displayableRepresentation)\" as renaming type", lineStyle: .info)
            
            writeLine(ProcessInfo.terminalArguments, lineStyle: .debug)
            writeLine(ProcessInfo.terminalArguments.count, lineStyle: .debug)
            
            guard ProcessInfo.terminalArguments.count != 0 else
            {
                writeLine("You forgot to provide the location of the files\n    \("To do so, add the location of the files to your previous command".font([.bold]))", lineStyle: .info)
                return
            }
            
            guard ProcessInfo.terminalArguments.count == 1 else
            {
                writeLine("Too many arguments provided", lineStyle: .error)
                return
            }
            
            
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

