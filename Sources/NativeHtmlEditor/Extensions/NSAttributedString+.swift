//
//  File.swift
//  
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import Foundation

public extension NSAttributedString {
    var fullRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}
