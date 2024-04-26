//
//  Process Files.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum RenamingError: Error
{
    case failedWhileRenaming
    case couldNotOpenSystemDictionary, couldNotGetRandomWord
}

func processFiles(files: [URL], transformationType: RenamingType) async throws -> Void
{
    writeLine("Starting the renaming process…".font([.bold]), lineStyle: .noDecoration)
    
    switch transformationType {
        case .randomUUID:
            let _: Void = await withThrowingTaskGroup(of: Void.self, returning: Void.self) { taskGroup in
                for file in files {
                    taskGroup.addTask(priority: .userInitiated)
                    {
                        try await processRandomUUID(file: file)
                    }
                }
            }
            
        case .randomWord:
            let _: Void = await withThrowingTaskGroup(of: Void.self, returning: Void.self) { taskGroup in
                for file in files {
                    taskGroup.addTask(priority: .userInitiated) {
                        try await processRandomWord(file: file)
                    }
                }
            }
    }
}

private func processRandomUUID(file: URL) async throws -> Void
{
    let extensionOfOriginalFile: String = file.pathExtension
    let parentLocationOfOriginalFile: URL = file.deletingLastPathComponent()
    
    let newUUID: UUID = UUID()
    
    writeLine("\(file.lastPathComponent.color(.gray)) → \("\(newUUID.uuidString).\(extensionOfOriginalFile)".color(.gray))", lineStyle: .info)
    
    do
    {
        try FileManager.default.moveItem(at: file, to: parentLocationOfOriginalFile.appending(component: newUUID.uuidString).appendingPathExtension(extensionOfOriginalFile))
    }
    catch
    {
        throw RenamingError.failedWhileRenaming
    }
}

private func processRandomWord(file: URL) async throws -> Void
{
    let extensionOfOriginalFile: String = file.pathExtension
    let parentLocationOfOriginalFile: URL = file.deletingLastPathComponent()
    
    guard let systemDictionaryLocation: URL = URL(string: "/usr/share/dict/words") else
    {
        throw RenamingError.couldNotOpenSystemDictionary
    }
    
    guard let randomWord: String = systemDictionaryLocation.randomLine() else
    {
        throw RenamingError.couldNotGetRandomWord
    }
    
    writeLine("\(file.lastPathComponent.color(.gray)) → \("\(randomWord).\(extensionOfOriginalFile)".color(.gray))", lineStyle: .info)
    
    do
    {
        try FileManager.default.moveItem(at: file, to: parentLocationOfOriginalFile.appending(component: randomWord).appendingPathExtension(extensionOfOriginalFile))
    }
    catch
    {
        throw RenamingError.failedWhileRenaming
    }
}
