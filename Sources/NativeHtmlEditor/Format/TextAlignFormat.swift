//
//  ListFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 27/05/2024.
//

import UIKit

public struct ListFormat: Format {
    public init() {}

    public var key: NSAttributedString.Key {
        .paragraphStyle
    }

    public var attributes: [NSAttributedString.Key : Any] {
        let ps = NSMutableParagraphStyle()

        ps.textLists = [
            NSTextList(markerFormat: .disc, options: 0)
        ]
        
        return [.paragraphStyle : ps]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? NSParagraphStyle else { return false }
        return value.textLists.count > 0
    }
}
