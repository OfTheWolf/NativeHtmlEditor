//
//  UIColor+.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 29/05/2024.
//

import UIKit

public extension UIColor {
    var components: (r: Int, g: Int, b: Int)? {
        guard let components = cgColor.components else { return nil }
        guard cgColor.numberOfComponents > 2 else { return nil }
        let rgb = components.prefix(3).map {Int($0 * 255)}
        let r = rgb[0]
        let g = rgb[1]
        let b = rgb[2]
        return (r, g, b)
    }

    var hasColor: Bool {
        guard let components else { return false }
        let r = components.r
        let g = components.g
        let b = components.b
        return r > 0 || g > 0 || b > 0
    }
}
