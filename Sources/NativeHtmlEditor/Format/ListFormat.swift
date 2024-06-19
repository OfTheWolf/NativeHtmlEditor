//
//  ListFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 27/05/2024.
//

import UIKit

public struct ListFormat: ParagraphFormat {
    private let currentParagraphStyle: NSMutableParagraphStyle

    public init(currentParagraphStyle: NSMutableParagraphStyle) {
        self.currentParagraphStyle = currentParagraphStyle
    }

    public var key: NSAttributedString.Key {
        .paragraphStyle
    }

    public var defaultParagraphStyle: NSParagraphStyle {
        let style = currentParagraphStyle.mutableCopy() as? NSMutableParagraphStyle
        style?.textLists = []
        style?.paragraphSpacing = 15
        return style ?? currentParagraphStyle
    }
    
    public var attributes: [NSAttributedString.Key : Any] {
        let style = currentParagraphStyle.mutableCopy() as? NSMutableParagraphStyle
        style?.paragraphSpacing = 0
        style?.textLists = [
            NSTextList(markerFormat: .disc, options: 0)
        ]
        return [.paragraphStyle : style ?? currentParagraphStyle]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? NSParagraphStyle else { return false }
        return value.textLists.count > 0
    }
}
