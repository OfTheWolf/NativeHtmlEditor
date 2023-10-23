//
//  Node.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 22/10/2023.
//

import Foundation

public protocol Node {
    var tag: Tag { get }
    var content: String { get }
}
