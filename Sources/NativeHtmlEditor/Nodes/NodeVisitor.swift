//
//  NodeVisitor.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import Foundation

/// Visit each paragraph and sub parts
public protocol NodeVisitor {
    func visit(_ element: Paragraph)
    func visit(_ element: Paragraph.Sub)
}
