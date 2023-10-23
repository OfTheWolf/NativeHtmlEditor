//
//  FontConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public struct FontConverter: NodeConverter {
    public init() {}

    public func convert(current: Node, attributes: [NSAttributedString.Key : Any], range: NSRange) -> Node {
        return current
    }
}
