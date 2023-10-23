//
//  StrikethroughConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public struct StrikethroughConverter: HtmlConverter {
    public init() {}

    public func convert(occurence: String, attributes: [NSAttributedString.Key : Any], range: NSRange) -> String {
        var retString = occurence
        if let style = attributes[.strikethroughStyle] as? Int, style == NSUnderlineStyle.single.rawValue {
            retString = "<s>" + retString + "</s>"
        }
        return retString
    }
}
