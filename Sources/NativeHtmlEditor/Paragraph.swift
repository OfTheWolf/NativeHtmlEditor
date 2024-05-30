//
//  Paragraph.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import Foundation

/// Model for attributed string parts 
public struct Paragraph {
    let attributedString: NSAttributedString
    let subs: [Sub]

    public struct Sub {
        let string: String
        let attributes: [NSAttributedString.Key: Any]
        let range: NSRange

        public func accept(visitor: NodeVisitor) {
            visitor.visit(self)
        }
    }

    public func accept(visitor: NodeVisitor) {
        for sub in subs {
            sub.accept(visitor: visitor)
        }
        visitor.visit(self)
    }
}
