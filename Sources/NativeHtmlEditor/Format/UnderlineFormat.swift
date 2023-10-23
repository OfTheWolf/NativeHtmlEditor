//
//  UnderlineFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct UnderlineFormat: Format {
    public init() {}

    public var key: NSAttributedString.Key {
        .underlineStyle
    }

    public var attributes: [NSAttributedString.Key : Any] {
        [key : NSUnderlineStyle.single.rawValue]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? Int else { return false }
        return value == NSUnderlineStyle.single.rawValue
    }
}
