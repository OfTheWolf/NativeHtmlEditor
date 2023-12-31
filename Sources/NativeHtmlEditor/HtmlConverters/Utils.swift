//
//  File.swift
//  
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import Foundation

public struct AttributedStringToHtml {
    private let converters: [NodeConverter]
    private let customTextProcessBlock: ((String) -> String)?

    public init(converters: [NodeConverter], customTextProcessBlock: ((String) -> String)? = nil) {
        self.converters = converters
        self.customTextProcessBlock = customTextProcessBlock
    }

    private func childNodes(attributedText: NSAttributedString) -> [Node] {
        let fullRange = attributedText.fullRange
        var nodes: [Node] = []
        attributedText.enumerateAttributes(in: fullRange, options: []) { (attributes, range, pointeeStop) in
            let occurence = attributedText.attributedSubstring(from: range).string
            var replacement = occurence.replacingOccurrences(of: "  ", with: " &nbsp;")
            if let block = customTextProcessBlock {
                replacement = block(replacement)
            }
            var current: Node = TextNode(content: replacement)
            converters.forEach {
                current = $0.convert(current: current, attributes: attributes, range: range)
            }
            nodes.append(current)
        }
        return nodes
    }

    private func paragraphNodes(attributedText: NSAttributedString) -> [ElementNode] {
        let nodes: [Node] = childNodes(attributedText: attributedText)
        var current = ElementNode(tag: .p)
        var paragraphs: [ElementNode] = [current]
        nodes.enumerated().forEach { index, node in
            let isLastNode = index == nodes.count - 1
            if node.content.contains("\n") {
                var comp = node.content.components(separatedBy: "\n")
                if isLastNode {
                    comp = comp.reversed().drop { $0.isEmpty }.reversed()
                }
                comp.enumerated().forEach { index, text in
                    let t = TextNode(content: text)
                    current.append(t)
                    if index < comp.count - 1 {
                        current = ElementNode(tag: .p)
                        paragraphs.append(current)
                    }
                }
            } else {
                current.append(node)
            }
        }
        return paragraphs
    }

    public func convert(attributedText: NSAttributedString, isPretty: Bool = false) -> String {
        let nodes = paragraphNodes(attributedText: attributedText)
        let content = nodes.map(\.content)
        return isPretty ? content.joined(separator: "\n") : content.joined()
    }
}
