//
//  UITextView+.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

public extension UITextView {

    func toggle(paragraphFormat: ParagraphFormat, selectedRange: NSRange) {
        let key = paragraphFormat.key
        let current = typingAttributes[key] as! NSMutableParagraphStyle
        if paragraphFormat.hasAttribute(current)  {
            let defaultParagraphStyle = paragraphFormat.defaultParagraphStyle
            typingAttributes[key] = defaultParagraphStyle
            textStorage.removeAttribute(key, range: selectedRange)
            textStorage.addAttribute(key, value: defaultParagraphStyle, range: selectedRange)
        } else {
            let attributes = paragraphFormat.attributes
            typingAttributes += attributes
            textStorage.addAttributes(attributes, range: selectedRange)
        }
    }

    func toggle(format: Format, selectedRange: NSRange) {
        let key = format.key
        let current = typingAttributes[key]
        if format.hasAttribute(current)  {
            typingAttributes.removeValue(forKey: key)
            textStorage.removeAttribute(key, range: selectedRange)
        } else {
            let attributes = format.attributes
            typingAttributes += attributes
            textStorage.addAttributes(attributes, range: selectedRange)
        }
    }

    func toggle(trait: UIFontDescriptor.SymbolicTraits, selectedRange: NSRange) {
        let typingFont = typingAttributes[.font] as? UIFont
        let font = typingFont ?? .preferredFont(forTextStyle: .body)
        var traits = font.fontDescriptor.symbolicTraits
        if traits.contains(trait) {
            traits.remove(trait)
        } else {
            traits.insert(trait)
        }
        let attr: [NSAttributedString.Key : Any] = [
            .font : font.withTraits(traits: traits)!
        ]
        typingAttributes += attr
        textStorage.addAttributes(attr, range: selectedRange)
    }

    //    static func toggleAlignment(_ textView: UITextView, _ alignment: NSTextAlignment) {
    //        let text = textView.text as NSString
    //        let paragraphRange = text.paragraphRange(for: textView.selectedRange)
    //        textView.typingAttributes.removeValue(forKey: .paragraphStyle)
    //        let paragraph = NSMutableParagraphStyle()
    //        textView.textStorage.removeAttribute(.paragraphStyle, range: paragraphRange)
    //        paragraph.alignment = alignment
    //        let attr: [NSAttributedString.Key : Any] = [
    //            .paragraphStyle: paragraph
    //        ]
    //        textView.typingAttributes += attr
    //        textView.textStorage.addAttributes(attr, range: paragraphRange)
    //    }
    //
    //    static func applyIndent(_ textView: UITextView, command: IndentCommand) {
    //        let text = textView.text as NSString
    //        let paragraphRange = text.paragraphRange(for: textView.selectedRange)
    //        let attributes = textView.attributedText.attributes(at: paragraphRange.location, effectiveRange: nil)
    //        let oldAttribute = attributes.first{$0.key == .paragraphStyle}
    //        let oldIndent = (oldAttribute?.value as? NSMutableParagraphStyle)?.firstLineHeadIndent ?? 0
    //        let paragraph = NSMutableParagraphStyle()
    //        let indent: CGFloat = 40.0
    //        if command == .increase {
    //            paragraph.firstLineHeadIndent = oldIndent + indent
    //        } else {
    //            paragraph.firstLineHeadIndent = max(0, oldIndent - indent)
    //        }
    //        let attr: [NSAttributedString.Key : Any] = [
    //            .paragraphStyle: paragraph
    //        ]
    //        textView.textStorage.removeAttribute(.paragraphStyle, range: paragraphRange)
    //        textView.textStorage.addAttributes(attr, range: paragraphRange)
    //        textView.typingAttributes.removeValue(forKey: .paragraphStyle)
    //        textView.typingAttributes += attr
    //    }
    //
    //    enum IndentCommand {
    //        case increase, decrease
    //    }
}
