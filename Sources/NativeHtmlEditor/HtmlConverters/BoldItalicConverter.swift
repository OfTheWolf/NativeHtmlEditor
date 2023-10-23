//
//  BoldItalicConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct BoldItalicConverter: NodeConverter {
    public init() {}


    public func convert(current: Node, attributes: [NSAttributedString.Key : Any], range: NSRange) -> Node {
        let font = attributes[.font] as! UIFont
        let isBold = font.fontDescriptor.symbolicTraits.contains(.traitBold)
        let isItalic = font.fontDescriptor.symbolicTraits.contains(.traitItalic)

        var child = current
        if isBold {
            child = ElementNode(tag: .strong, children: [child])
        }
        if isItalic {
            child = ElementNode(tag: .em, children: [child])
        }
        return child
    }
}
