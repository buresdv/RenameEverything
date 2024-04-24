//
//  ANSI Colors.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

enum ANSIColor: String
{
    case black = "\u{001B}[30m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case magenta = "\u{001B}[35m"
    case cyan = "\u{001B}[36m"
    case white = "\u{001B}[37m"

    case blackBright = "\u{001B}[90m"
    case redBright = "\u{001B}[91m"
    case greenBright = "\u{001B}[92m"
    case yellowBright = "\u{001B}[93m"
    case blueBright = "\u{001B}[94m"
    case magentaBright = "\u{001B}[95m"
    case cyanBright = "\u{001B}[96m"
    case whiteBright = "\u{001B}[97m"

    case reset = "\u{001B}[0m"
}

enum ANSIColorBackground: String
{
    case black = "\u{001B}[40m"
    case red = "\u{001B}[41m"
    case green = "\u{001B}[42m"
    case yellow = "\u{001B}[43m"
    case blue = "\u{001B}[44m"
    case magenta = "\u{001B}[45m"
    case cyan = "\u{001B}[46m"
    case white = "\u{001B}[47m"
}

// TODO: Implement these RGB colors
/*
enum ANSIColorRGB
{
    case rgb(red: Int, green: Int, blue: Int)
    
    var colorCode: String
    {
        switch self
        {
            case let .rgb(red, green, blue):
                return "\u{001B}[38;2;\(red);\(green);\(blue)m"
        }
    }
}

enum ANSIColorRGBBackground
{
    case rgb(red: Int, green: Int, blue: Int)
    
    var colorCode: String
    {
        switch self
        {
            case let .rgb(red, green, blue):
                return "\u{001B}[48;2;{\(red)};{\(green)};{\(blue)}m"
        }
    }
}
*/
