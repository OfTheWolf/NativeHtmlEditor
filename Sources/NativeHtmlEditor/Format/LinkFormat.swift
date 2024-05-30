//
//  LinkFormat.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct LinkFormat: Format {
    private let link: String

    public init(link: String) {
        self.link = link
    }

    public var key: NSAttributedString.Key {
        .link
    }

    public var attributes: [NSAttributedString.Key : Any] {
        [key : link]
    }

    public func hasAttribute(_ value: Any?) -> Bool {
        guard let value = value as? String else { return false }
        return !value.isEmpty
    }
}
