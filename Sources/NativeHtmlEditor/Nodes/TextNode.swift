//
//  TextNode.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public struct TextNode: Node {
    public let content: String

    public init(content: String) {
        self.content = content
    }
}
