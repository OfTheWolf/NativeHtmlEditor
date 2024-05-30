//
//  NSAttributedString+.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import Foundation

public extension NSAttributedString {
    var fullRange: NSRange {
        NSRange(location: 0, length: self.length)
    }

/// Split attributed text components into paragraphs
    func components() -> [Paragraph] {
        let range = NSMakeRange(0, length)
        let string = string as NSString
        var items: [Paragraph] = []
        string.enumerateSubstrings(in: range, options: .byParagraphs) { sub, subRange, enclosingRange, stop in
            let part = self.attributedSubstring(from: subRange)
            var subs: [Paragraph.Sub] = []
            self.enumerateAttributes(in: subRange) { attributes, range, _ in
                let text = self.attributedSubstring(from: range).string
                let sub = Paragraph.Sub(string: text, attributes: attributes, range: range)
                subs.append(sub)
            }
            items.append(Paragraph(attributedString: part, subs: subs))
        }
        return items
    }
}
