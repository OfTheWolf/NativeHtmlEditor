//
//  Node.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import Foundation

// MARK: - Node
class Node: CustomStringConvertible {
    weak var parent: Node? = nil
    var children: [Node] = []

    var description: String { "" }

    func append(_ node: Node) {
        node.parent = self
        children.append(node)
    }

    func append(_ nodes: [Node]) {
        for node in nodes {
            append(node)
        }
    }

    func prettyPrint(_ prefix: String = "") -> String {
        ""
    }

}

// MARK: - TextNode
class TextNode: Node {
    let content: String

    init(content: String) {
        self.content = content
    }

    override var description: String {
        content
    }

    override func prettyPrint(_ prefix: String = "") -> String {
        content
    }
}

// MARK: - ElementNode
class ElementNode: Node, Equatable {
    let tag: Tag
    var attributes: [Attribute] = []

    init(tag: Tag, attributes: [Attribute] = [], children: [Node] = []) {
        self.tag = tag
        self.attributes = attributes//.filter(for: tag)
        super.init()
        append(children)
    }

    enum Tag: String {
        case p, em, strong, div, span, a, del, ul, ol, li
    }

    struct Attribute: Hashable {
        let key: Key
        let value: String

        enum Key: Hashable, Equatable {
            case style, href, custom(String)

            var string: String {
                switch self {
                case .style:
                    "style"
                case .href:
                    "href"
                case .custom(let key):
                    key
                }
            }
        }
    }

    ///    Merge attributes with mutiple styles
    var cssStyle: String {
        Dictionary(grouping: attributes, by: \.key).map {
            " \($0.key)='\($0.value.map(\.value).joined(separator: "; "))'"
        }.joined()
    }

    var startTag: String {
        "<"
        + tag.rawValue
        + cssStyle
        + ">"
    }

    var endTag: String {
        "</\(tag.rawValue)>"
    }

    var startSeparator: String {
        (!children.isEmpty && children.first is ElementNode) ? "\n" : ""
    }

    var endSeparator: String {
        (!children.isEmpty && children.first is ElementNode) ? "\n" : ""
    }

    override var description: String {
        startTag
        + children.map(\.description).joined()
        + endTag
    }

    override func prettyPrint(_ prefix: String = "") -> String {
        prefix
        + startTag
        + startSeparator
        + children.map({ node in
            node.prettyPrint(prefix + "\t")
        }).joined(separator: "\n")
        + endSeparator
        + (endSeparator.isEmpty ? "" : prefix)
        + endTag
    }

    static func == (lhs: ElementNode, rhs: ElementNode) -> Bool {
        lhs.tag == rhs.tag
    }
}
