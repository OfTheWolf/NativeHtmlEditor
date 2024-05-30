//
//  ListState.swift
//  NativeHtmlEditor
//
//  Created by Ugur Bozkurt on 30/05/2024.
//

import UIKit

/// Stores the last state of the list items
class ListState {
    var hasList: Bool {
        !textLists.isEmpty
    }

    var textLists : [NSTextList] = [] {
        didSet {
            guard let item = currentTextList else { return }
            start = item.startingItemNumber
            level = textLists.count
        }
    }

    var currentTextList: NSTextList? {
        textLists.last
    }

    var start: Int = 0
    var level: Int = 1
    var previousLevel: Int = 1

    var currentIndex: Int {
        start + offset
    }

    var offset: Int {
        offsets[level] ?? 0
    }

    var offsets: [Int: Int] = [:]

    var marker: String {
        guard let item = currentTextList else { return "" }
        return item.marker(forItemNumber: currentIndex)
    }

    func increaseOffset() {
        offsets[level] = offset + 1
    }

    func shouldInclude(_ text: String) -> Bool {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return text != marker
    }

    func reset() {
        offsets = [:]
    }

    var tag: ElementNode.Tag? {
        guard let item = textLists.last else { return nil }
        return item.isOrderedList ? .ol : .ul
    }
}
