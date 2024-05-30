//
//  AttributesParser.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import Foundation

public protocol AttributesParser {
    func accept(_ visitor: AttributesVisitor)
}

public class LinkAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class FontAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class ForegroundAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class BackgroundAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class ListAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class UnderlineAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class ParagraphAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}

public class StrikethroughAttributeParser: AttributesParser {
    public func accept(_ visitor: any AttributesVisitor) {
        visitor.visit(self)
    }
}
