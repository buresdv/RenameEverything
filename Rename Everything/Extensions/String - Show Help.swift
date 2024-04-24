//
//  String - Show Help.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

extension String
{
    static let helpText: String = """
RenameEverything: A tool for mass-renaming of files in a folder

USAGE:
  renameEverything [optional arguments] [folder location]

OPTIONAL ARGUMENTS:
  --renameType: Specify how files should be renamed
    POSSIBLE TYPES:
      randomUUID: Rename files to random UUIDs
      randomWord: Rename files to random words

OPTIONS:
  --help: Show this help
"""
}
