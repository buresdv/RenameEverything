//
//  Process Info - Terminal Arguments.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

extension ProcessInfo
{
    static var terminalArguments: [String] =
    {
        return CommandLine.arguments.dropFirst()
    }()
}
