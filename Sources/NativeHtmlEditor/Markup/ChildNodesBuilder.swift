//
//  ChildNodesBuilder.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 28/05/2024.
//

import Foundation

/// Build inner nodes by traversing the paragraph subs
class ChildNodesBuilder: MarkupVisitor {
    var nodes: [Node] = []

    var content: String
    var listState: ListState
    var tag: ElementNode.Tag = .p

    init(content: String, listSate: ListState) {
        self.content = content
        self.listState = listSate
        nodes = [TextNode(content: content)]
    }

    func visit(_ element: BoldMarkup) {
        nodes = [ElementNode(tag: .strong, children: nodes)]
    }

    func visit(_ element: ItalicMarkup) {
        nodes = [ElementNode(tag: .em, children: nodes)]
    }

    func visit(_ element: ListMarkup) {
        listState.textLists = element.items
        guard let listTag = listState.tag else { return }
        tag = listTag
        guard listState.shouldInclude(content) else {
            nodes = []
            return
        }
        nodes = [ElementNode(tag: .li, children: nodes)]
        listState.increaseOffset()
    }

    func visit(_ element: LinkMarkup) {
        let attr = ElementNode.Attribute(key: .href, value: element.url)
        nodes = [ElementNode(tag: .a, attributes: [attr], children: nodes)]
    }

    func visit(_ element: ColorMarkup) {
        guard let cssStyle = element.cssValue else { return }
        let attr = ElementNode.Attribute(key: .style, value: cssStyle)
        applyStyleToCurrent(for: [attr])
    }

    func visit(_ element: BackgroundColorMarkup) {
        guard let cssStyle = element.cssValue else { return }
        let attr = ElementNode.Attribute(key: .style, value: cssStyle)
        applyStyleToCurrent(for: [attr])
    }

    func visit(_ element: UnderlineMarkup) {
        guard let cssStyle = element.cssValue else { return }
        let attr = ElementNode.Attribute(key: .style, value: cssStyle)
        applyStyleToCurrent(for: [attr])
    }
    
    func visit(_ element: StrikethroughMarkup) {
        nodes = [ElementNode(tag: .del, children: nodes)]
    }

    func visit(_ element: TextAlignmentMarkup) {
        guard let cssStyle = element.cssValue else { return }
        let attr = ElementNode.Attribute(key: .style, value: cssStyle)
        applyStyleToCurrent(for: [attr])
    }

    private func applyStyleToCurrent(for attributes: [ElementNode.Attribute]) {
        guard let last = nodes.last else { return }
        if last is TextNode {
            nodes = [ElementNode(tag: .span, attributes: attributes, children: nodes)]
        } else if let currentNode = last as? ElementNode, currentNode.tag != .a {
            currentNode.attributes += attributes
        }
    }
}
