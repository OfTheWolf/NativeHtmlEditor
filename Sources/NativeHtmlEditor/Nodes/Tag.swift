//
//  Tag.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public enum Tag: String {
    case h1, h2, p, span, em, strong, u, s
    
    var open: String {
        "<\(self)>"
    }
    
    var close: String {
        "</\(self)>"
    }
}
