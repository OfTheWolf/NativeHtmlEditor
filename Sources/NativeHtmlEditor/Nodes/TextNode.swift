//
//  TextNode.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public struct TextNode: Node {
    public let tag: Tag
    public let content: String

    public init(tag: Tag, content: String) {
        self.tag = tag
        self.content = content
    }
}
