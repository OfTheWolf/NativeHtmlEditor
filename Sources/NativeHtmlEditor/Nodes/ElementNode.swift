//
//  ElementNode.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public class ElementNode: Node, CustomStringConvertible {
    public let tag: Tag
    public var children: [Node] = []

    public init(tag: Tag, children: [Node] = []) {
        self.tag = tag
        self.children = children
    }

    public func append(_ node: Node) {
        children.append(node)
    }

    public var content: String {
        var out = tag.open
        children.forEach { node in
            out += node.content
        }
        out += tag.close
        return out
    }

    public var description: String {
        return "tag: "
        + tag.rawValue
        + ", \n"
        + "content: "
        + content
    }
}
