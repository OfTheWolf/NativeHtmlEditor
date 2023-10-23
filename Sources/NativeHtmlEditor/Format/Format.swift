//
//  Format.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public protocol Format {
    init()
    var key: NSAttributedString.Key { get }
    var attributes: [NSAttributedString.Key : Any] { get }
    func hasAttribute(_ value: Any?) -> Bool
}
