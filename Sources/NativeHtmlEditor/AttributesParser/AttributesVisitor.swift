//
//  AttributesVisitor.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import Foundation

public protocol AttributesVisitor {
    func visit(_ parser: LinkAttributeParser)
    func visit(_ parser: FontAttributeParser)
    func visit(_ parser: ForegroundAttributeParser)
    func visit(_ parser: BackgroundAttributeParser)
    func visit(_ parser: ListAttributeParser)
    func visit(_ parser: UnderlineAttributeParser)
    func visit(_ parser: StrikethroughAttributeParser)
    func visit(_ parser: ParagraphAttributeParser)
}
