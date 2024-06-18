//
//  TextAlignFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 27/05/2024.
//

import UIKit

public struct TextAlignFormat: Format {
    private let alignmet: NSTextAlignment
    private let currentParagraphStyle: NSMutableParagraphStyle

    public init(alignmet: NSTextAlignment, currentParagraphStyle: NSMutableParagraphStyle) {
        self.alignmet = alignmet
        self.currentParagraphStyle = currentParagraphStyle
    }

    public var key: NSAttributedString.Key {
        .paragraphStyle
    }

    public var attributes: [NSAttributedString.Key : Any] {
        let style = currentParagraphStyle.mutableCopy() as? NSMutableParagraphStyle
        style?.alignment = alignmet
        return [.paragraphStyle : style ?? currentParagraphStyle]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? NSParagraphStyle else { return false }
        return value.alignment == alignmet
    }
}
