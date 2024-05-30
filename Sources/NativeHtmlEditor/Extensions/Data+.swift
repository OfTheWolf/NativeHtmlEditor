//
//  Data+.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import Foundation

public extension Data {
    var htmlAttributedString: NSAttributedString?  {
        try? NSAttributedString(
            data: self,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
    }
}
