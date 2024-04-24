//
//  String - Show Help.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation
import SwiftyTerminalColors

extension String
{
    static let helpText: String = """
\("\("Rename".color(.cyan))\("Everything".color(.blue))"): A tool for randomly mass-renaming files in a folder

\("Usage:".font([.bold]))
  renameEverything [optional arguments] [folder location]

\("Optional Arguments:".font([.bold]))
  --renameType: Specify how files should be renamed
    \("Possible types:".font([.italic]).color(.blue))
      randomUUID: Rename files to random UUIDs
      randomWord: Rename files to random words
    \("Example usage:".font([.italic]).color(.blue))
      renameEverything --renameType randomUUID [folder location]
        \("Will rename all files in the specified folder to random UUIDs".font([.italic]))
      renameEverything --renameType randomWord [folder location]
        \("Will rename all files in the specified folder to random English words".font([.italic]))

\("Options:".font([.bold]))
  --help: Show this help
"""
}
