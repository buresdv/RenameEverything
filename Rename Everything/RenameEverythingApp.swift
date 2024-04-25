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
            
            writeLine("All arguments received from the user:\n    \("\(ProcessInfo.terminalArguments)".color(.gray))", lineStyle: .debug)
            
            guard let indexOfDebugFlag = ProcessInfo.terminalArguments.firstIndex(of: "--debug") else
            {
                writeLine("Could not parse arguments: Could not find debug flag index", lineStyle: .error)
                return
            }
            
            ProcessInfo.terminalArguments.remove(at: indexOfDebugFlag)
            
            writeLine("Arguments left after parsing out the debug flag:\n    \("\(ProcessInfo.terminalArguments)".color(.gray))", lineStyle: .debug)
        }
        
        do
        {
            AppGlobals.shared.transformationType = try parseRenamingType(arguments: &ProcessInfo.terminalArguments)
            
            writeLine("Will use \"\(AppGlobals.shared.transformationType.displayableRepresentation)\" as renaming type", lineStyle: .info)
            
            
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
            
            writeLine("Final arguments after all modifications:\n    \("\(ProcessInfo.terminalArguments)".color(.gray))", lineStyle: .debug)
            
            guard let folderLocation = ProcessInfo.terminalArguments.first else
            {
                writeLine("You did not provide a valid file location", lineStyle: .error)
                return
            }
            
            do
            {
                // MARK: - Getting of files form a folder, then displaying them if debug is enabled
                let filesInFolder: [URL] = try getFiles(from: folderLocation)
                
                writeLine("Found \(filesInFolder.count) files in folder, including:", lineStyle: .debug)
                
                if AppGlobals.shared.isDebugModeEnabled
                {
                    for fileLocation in filesInFolder.prefix(5)
                    {
                        writeLine("    \(fileLocation.path)".color(.gray), lineStyle: .noDecoration)
                    }
                }
                
                // MARK: - Renaming of files
                do
                {
                    try await processFiles(files: filesInFolder, transformationType: AppGlobals.shared.transformationType)
                }
            }
            catch let fileRetrievalError as FileLoadingError
            {
                switch fileRetrievalError {
                    case .folderDoesNotExist:
                        writeLine("Folder \(folderLocation) is not valid", lineStyle: .error)
                    case .couldNotEncodeURL:
                        writeLine("Could not verify that \(folderLocation) is a valid location", lineStyle: .error)
                    case .couldNotAccessFolder:
                        writeLine("Could not acess \(folderLocation)", lineStyle: .error)
                }
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

