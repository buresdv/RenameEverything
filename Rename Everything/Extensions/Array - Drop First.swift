//
//  Array - Drop First.swift
//  Rename Everything
//
//  Created by David Bureš on 24.04.2024.
//

import Foundation

extension Array
{
    mutating func dropFirst() -> [Element]
    {
        remove(at: 0)
        return self
    }
}
