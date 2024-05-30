//
//  NSTextList.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import UIKit

extension NSTextList {
    /// Backward compatibility for isOrdered
    var isOrderedList: Bool {
        if #available(iOS 16.0, *) {
            return isOrdered
        } else {
            let unorderedFormats = [MarkerFormat.box,
                           MarkerFormat.check,
                           MarkerFormat.circle,
                           MarkerFormat.diamond,
                           MarkerFormat.disc,
                           MarkerFormat.hyphen,
                           MarkerFormat.square]
            let result = unorderedFormats.filter { format in
                markerFormat.rawValue.hasPrefix(format.rawValue)
            }
            return result.isEmpty
        }
    }
}
