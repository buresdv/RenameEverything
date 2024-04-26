//
//  URL - Get Random Line from File.swift
//  Rename Everything
//
//  Created by David Bureš on 25.04.2024.
//

import Foundation

extension URL
{
    // Get a random line from a specified file URL
    func randomLine() -> String?
    {
        guard let file = FileHandle(forReadingAtPath: self.path) else {
            return nil
        }
        
        let fileSize = file.seekToEndOfFile()
        
        guard fileSize > 0 else {
            return nil
        }
        
        let randomOffset = Int64.random(in: 0..<Int64(fileSize))
        file.seek(toFileOffset: UInt64(randomOffset))
        
        var lineData = Data()
        while true {
            let byte = file.readData(ofLength: 1)
            if byte.first == 10 || byte.isEmpty {
                break
            }
            lineData.append(byte)
        }
        
        /// If the random line is empty, try again
        if lineData.isEmpty
        {
            let newAttempt = self.randomLine()
            guard let newAttemptData = newAttempt?.data(using: .utf8) else
            {
                return nil
            }
            lineData = newAttemptData
        }
        
        return String(data: lineData, encoding: .utf8)
    }
}
