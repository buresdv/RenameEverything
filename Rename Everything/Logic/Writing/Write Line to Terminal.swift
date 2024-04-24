//
//  Write Line to Terminal.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum LineStyle: String
{
    case noDecoration
    case info, error
    case debug
}

func writeLine(_ whatToWrite: Any, lineStyle: LineStyle = .noDecoration)
{
    switch lineStyle {
        case .noDecoration:
            print(whatToWrite)
        case .info:
            print("\("[".color(.cyanBright))\("i".color(.gray))\("]".color(.cyanBright)) \(whatToWrite)")
        case .error:
            print("\("[".color(.redBright))\("x".color(.red))\("]".color(.redBright)) \(whatToWrite)")
        case .debug:
            if AppGlobals.shared.isDebugModeEnabled
            {
                print("\("[".color(.yellowBright))\("D".color(.yellow))\("]".color(.yellowBright)) \(whatToWrite)")
            }
    }
}
