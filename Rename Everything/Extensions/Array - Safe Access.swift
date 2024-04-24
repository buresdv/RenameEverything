//
//  Array - Safe Access.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index
{
    subscript(safe index: Index) -> Iterator.Element?
    {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
