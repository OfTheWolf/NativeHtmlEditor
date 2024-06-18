//
//  BackgroundColorFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct BackgroundColorFormat: Format {
    let color: UIColor

    public init(color: UIColor) {
        self.color = color
    }

    public var key: NSAttributedString.Key {
        .backgroundColor
    }

    public var attributes: [NSAttributedString.Key : Any] {
        [key : color]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? UIColor else { return false }
        return value == color
    }
}
