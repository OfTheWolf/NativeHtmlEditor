//
//  AttributeVisitor.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import UIKit

class MarkupsBuilder: AttributesVisitor {
    let attributes: [NSAttributedString.Key: Any]
    
    init(attributes: [NSAttributedString.Key : Any]) {
        self.attributes = attributes
    }

    var markups: [Markup] = []

    func visit(_ parser: LinkAttributeParser) {
        guard let link = attributes[.link] as? URL else { return }
        markups.append(LinkMarkup(url: link.absoluteString))
    }
    
    func visit(_ parser: FontAttributeParser) {
        guard let font = attributes[.font] as? UIFont else { return }
        let descriptor = font.fontDescriptor
        if descriptor.symbolicTraits.contains(.traitBold) {
            markups.append(BoldMarkup())
        }
        if descriptor.symbolicTraits.contains(.traitItalic) {
            markups.append(ItalicMarkup())
        }
    }
    
    func visit(_ parser: ForegroundAttributeParser) {
        guard let color = attributes[.foregroundColor] as? UIColor else { return }
        guard color.hasColor else { return }
        markups.append(ColorMarkup(color: color))
    }

    func visit(_ parser: BackgroundAttributeParser) {
        guard let color = attributes[.backgroundColor] as? UIColor else { return }
        guard color.hasColor else { return }
        markups.append(BackgroundColorMarkup(color: color))
    }

    func visit(_ parser: ListAttributeParser) {
        guard let style = attributes[.paragraphStyle] as? NSParagraphStyle else { return }
        guard !style.textLists.isEmpty else { return }
        markups.append(ListMarkup(items: style.textLists))
    }

    func visit(_ parser: UnderlineAttributeParser) {
        guard let style = attributes[.underlineStyle] as? Int else { return }
        markups.append(UnderlineMarkup(lineStyle: style))
    }

    func visit(_ parser: StrikethroughAttributeParser) {
        guard let style = attributes[.strikethroughStyle] as? Int else { return }
        markups.append(StrikethroughMarkup(lineStyle: style))
    }

    func visit(_ parser: ParagraphAttributeParser) {
        guard let style = attributes[.paragraphStyle] as? NSParagraphStyle else { return }
        if style.alignment != .left {
            markups.append(TextAlignmentMarkup(alignment: style.alignment))
        }
    }
}


