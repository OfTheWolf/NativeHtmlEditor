//
//  MarkupVisitor.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import Foundation

protocol MarkupVisitor {
    func visit(_ element: BoldMarkup)
    func visit(_ element: ItalicMarkup)
    func visit(_ element: ListMarkup)
    func visit(_ element: LinkMarkup)
    func visit(_ element: ColorMarkup)
    func visit(_ element: BackgroundColorMarkup)
    func visit(_ element: UnderlineMarkup)
    func visit(_ element: StrikethroughMarkup)
    func visit(_ element: TextAlignmentMarkup)
}
