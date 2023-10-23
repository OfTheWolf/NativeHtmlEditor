//
//  FontConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public struct FontConverter: HtmlConverter {
    public init() {}

    public func convert(occurence: String, attributes: [NSAttributedString.Key : Any], range: NSRange) -> String {
        let retString = occurence
        return retString
    }
}
