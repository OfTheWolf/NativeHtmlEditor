//
//  Format.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public protocol Format {
    var key: NSAttributedString.Key { get }
    var attributes: [NSAttributedString.Key : Any] { get }
    func hasAttribute(_ value: Any?) -> Bool
}

public protocol ParagraphFormat: Format {
    var defaultParagraphStyle: NSParagraphStyle { get }
}
