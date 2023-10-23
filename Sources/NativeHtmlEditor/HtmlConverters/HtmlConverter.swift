//
//  HtmlConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 18/10/2023.
//

import UIKit

public protocol HtmlConverter {
    init()
    func convert(occurence: String, attributes: [NSAttributedString.Key : Any], range: NSRange) -> String
}
