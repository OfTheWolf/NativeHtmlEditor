//
//  HTMLTreeBuilder.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import UIKit

/// Convert attributed string to html by traversing the whole attributed string parts
public class HTMLTreeBuilder: NodeVisitor {

    private let parsers: [AttributesParser]

    public init(parsers: [AttributesParser] = allParsers) {
        self.parsers = parsers
    }

    private var listState = ListState()
    private var root: ElementNode!
    private var children: [Node] = []
    private var nodes: [ElementNode] = []
    private var currentTag: ElementNode.Tag = .p

    public static var allParsers: [AttributesParser] = [
        LinkAttributeParser(),
        FontAttributeParser(),
        ForegroundAttributeParser(),
        BackgroundAttributeParser(),
        UnderlineAttributeParser(),
        StrikethroughAttributeParser(),
        ListAttributeParser(),
        ParagraphAttributeParser(),
    ]

    public func toHtml() -> String {
        nodes.map{$0.prettyPrint()}.joined(separator: "\n")
    }

    public func visit(_ element: Paragraph) {
        switch currentTag {
        case .p:
            listState.reset()
            fallthrough
        case .ol, .ul:
            if listState.level > listState.previousLevel {
                let node = ElementNode(tag: currentTag, children: children)
                root.append(node)
                root = node
            } else if listState.level < listState.previousLevel {
                root = root.parent as? ElementNode
                root.append(children)
            } else {
                fallthrough
            }
        default:
            if root == nil || currentTag != root.tag || currentTag == .p {
                root = ElementNode(tag: currentTag)
                nodes.append(root)
            }
            root.append(children)
        }
        children = []
        listState.previousLevel = listState.level
    }

    public func visit(_ sub: Paragraph.Sub) {
        let subNodesCollector = ChildNodesBuilder(content: sub.string, listSate: listState)
        let markupsCollector = MarkupsBuilder(attributes: sub.attributes)
        parsers.forEach{$0.accept(markupsCollector)}
        let markups = markupsCollector.markups
        markups.forEach { markup in
            markup.accept(subNodesCollector)
        }
        children += subNodesCollector.nodes
        currentTag  = subNodesCollector.tag
    }
}
