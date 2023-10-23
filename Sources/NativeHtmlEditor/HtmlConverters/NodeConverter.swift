//
//  ElementConverter.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 18/10/2023.
//

import UIKit

public protocol NodeConverter {
    init()
    func convert(current: Node, attributes: [NSAttributedString.Key : Any], range: NSRange) -> Node
}
