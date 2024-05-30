//
//  Markup.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import UIKit

/// Models for NSAttributedString attributes
protocol Markup {
    func accept(_ visitor: MarkupVisitor)
}

public class BoldMarkup: Markup {
    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }
}

public class LinkMarkup: Markup {
    let url: String

    init(url: String) {
        self.url = url
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }
}

public class ItalicMarkup: Markup {
    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }
}

public class ListMarkup: Markup {
    let items: [NSTextList]

    init(items: [NSTextList]) {
        self.items = items
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }
}

public class ColorMarkup: Markup {
    let color: UIColor

    init(color: UIColor) {
        self.color = color
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }

    var cssValue: String? {
        guard let (r, g, b) = color.components else { return nil }
        return "color: rgb(\(r), \(g), \(b))"
    }
}

public class BackgroundColorMarkup: Markup {
    let color: UIColor

    init(color: UIColor) {
        self.color = color
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }

    var cssValue: String? {
        guard let (r, g, b) = color.components else { return nil }
        return "background-color: rgb(\(r), \(g), \(b))"
    }
}

public class UnderlineMarkup: Markup {
    let lineStyle: Int

    init(lineStyle: Int) {
        self.lineStyle = lineStyle
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }

    var cssValue: String? {
        switch NSUnderlineStyle(rawValue: lineStyle) {
        case .single:
            "text-decoration: underline"
        default:
            nil
        }
    }
}

public class StrikethroughMarkup: Markup {
    let lineStyle: Int

    init(lineStyle: Int) {
        self.lineStyle = lineStyle
    }

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }
}

public class TextAlignmentMarkup: Markup {
    let alignment: NSTextAlignment

    init(alignment: NSTextAlignment) {
        self.alignment = alignment
    }

    private let prefix = "text-align"

    func accept(_ visitor: MarkupVisitor) {
        visitor.visit(self)
    }

    var cssValue: String? {
        switch alignment {
        case .center:
            "\(prefix): center"
        case .right:
            "\(prefix): right"
        default:
            nil
        }
    }
}
