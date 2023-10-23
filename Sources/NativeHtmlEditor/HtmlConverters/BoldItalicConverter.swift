//
//  BoldItalicConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct BoldItalicConverter: HtmlConverter {
    public init() {}
    
    public func convert(occurence: String, attributes: [NSAttributedString.Key : Any], range: NSRange) -> String {
        var retString = occurence
        let font = attributes[.font] as! UIFont
        let isBold = font.fontDescriptor.symbolicTraits.contains(.traitBold)
        let isItalic = font.fontDescriptor.symbolicTraits.contains(.traitItalic)
        if isBold {
            retString = "<strong>" + retString + "</strong>"
        }
        if isItalic {
            retString = "<em>" + retString + "</em>"
        }
        return retString
    }
}
