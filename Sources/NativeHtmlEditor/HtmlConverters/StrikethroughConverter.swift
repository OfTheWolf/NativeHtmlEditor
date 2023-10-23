//
//  StrikethroughConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct StrikethroughConverter: NodeConverter {
    public init() {}

    public func convert(current: Node, attributes: [NSAttributedString.Key : Any], range: NSRange) -> Node {
        if let style = attributes[.strikethroughStyle] as? Int, style == NSUnderlineStyle.single.rawValue {
            return ElementNode(tag: .s, children: [current])
        } else {
            return current
        }
    }
}
