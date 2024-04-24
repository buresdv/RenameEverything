//
//  Get Files.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum FileLoadingError: Error
{
    case folderDoesNotExist, couldNotEncodeURL, couldNotAccessFolder
}

func getFiles(from folderPath: String) throws -> [URL]
{
    guard FileManager.default.fileExists(atPath: folderPath) else
    {
        throw FileLoadingError.folderDoesNotExist
    }
    
    guard let folderURL = URL(string: folderPath) else
    {
        throw FileLoadingError.couldNotEncodeURL
    }
    
    guard let files = try? FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: [.isRegularFileKey, .isDirectoryKey]) else
    {
        throw FileLoadingError.couldNotAccessFolder
    }
    
    return files
}
