//
//  Array+Paragraph.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import Foundation

public extension Array {
    init(_ attributedSubstring: NSAttributedString) where Element == Paragraph {
        self.init(attributedSubstring.components())
    }
}
