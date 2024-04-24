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
  renameEverything [optional flags] [optional arguments] [folder location]
  \("By default, the app will rename all items in the target folder to random UUIDs.".color(.gray))
  \("See below for other ways of renaming them".color(.gray))

\("Optional Arguments:".font([.bold]))
  --renameType: Specify how files should be renamed
    \("Possible types:".font([.italic]).color(.blue))
      randomUUID: \("Rename files to random UUIDs".color(.gray))
      randomWord: \("Rename files to random words".color(.gray))
    \("Example usage:".font([.italic]).color(.blue))
      renameEverything \("--renameType randomUUID".color(.red)) [folder location]
        \("Will rename all files in the specified folder to random UUIDs".font([.italic]).color(.gray))
      renameEverything \("--renameType randomWord".color(.red)) [folder location]
        \("Will rename all files in the specified folder to random English words".font([.italic]).color(.gray))
\("Optional Flags:".font([.bold]))
  --debug: Enable debug mode
  --help: Show this help
"""
}
