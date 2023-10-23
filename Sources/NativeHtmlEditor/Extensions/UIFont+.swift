//
//  UIFont+.swift
//  
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont? {
        guard let descriptorL = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else{
            return nil
        }
        return UIFont(descriptor: descriptorL, size: 0)
    }
}
