//
//  ViewController.swift
//  Example
//
//  Created by Ugur Bozkurt on 23/10/2023.
//

import UIKit
import NativeHtmlEditor

class ViewController: UIViewController, UIToolbarDelegate, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputAccessoryView = makeToolbar()
        textView.delegate = self
        textView.attributedText = Mock.sample2.attributedString
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(systemItem: .refresh, primaryAction: .init(handler: { [unowned self] _ in
                self.textView.attributedText = Mock.sample1.attributedString
            }))
        ]
        updateUndoRedoButtons()
    }

    private lazy var undoButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.left"), primaryAction: self.undoAction)
    }()

    private lazy var redoButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.right"), primaryAction: self.redoAction)
    }()

    private func makeToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.items = [
//            UIBarButtonItem(image: UIImage(systemName: "text.alignleft"), primaryAction: leftAlignAction),
//            UIBarButtonItem(image: UIImage(systemName: "text.aligncenter"), primaryAction: centerAlignAction),
//            UIBarButtonItem(image: UIImage(systemName: "text.alignright"), primaryAction: rightAlignAction),
//            UIBarButtonItem(image: UIImage(systemName: "text.justify"), primaryAction: justifyAction),
            UIBarButtonItem(image: UIImage(systemName: "bold"), primaryAction: boldAction),
            UIBarButtonItem(image: UIImage(systemName: "italic"), primaryAction: italicAction),
            UIBarButtonItem(image: UIImage(systemName: "underline"), primaryAction: underlineAction),
            UIBarButtonItem(image: UIImage(systemName: "strikethrough"), primaryAction: strikeThroughAction),
            undoButton,
            redoButton,
            .flexibleSpace(),
            UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
        ]
        toolbar.sizeToFit()
        return toolbar
    }

    private lazy var undoAction: UIAction = UIAction { _ in
        self.textView.undoManager?.undo()
        self.updateUndoRedoButtons()
    }

    private lazy var redoAction: UIAction = UIAction { _ in
        self.textView.undoManager?.redo()
        self.updateUndoRedoButtons()
    }

    private lazy var leftAlignAction: UIAction = UIAction { _ in

    }

    private lazy var rightAlignAction: UIAction = UIAction { _ in

    }

    private lazy var centerAlignAction: UIAction = UIAction { _ in

    }

    private lazy var justifyAction: UIAction = UIAction { _ in

    }

    private lazy var boldAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        self.textView.toggle(trait: .traitBold, selectedRange: selectedRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(trait: .traitBold, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
    }

    private lazy var italicAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        self.textView.toggle(trait: .traitItalic, selectedRange: selectedRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(trait: .traitItalic, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
    }

    private lazy var underlineAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        let format = ListFormat()
        self.textView.toggle(format: format, selectedRange: selectedRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(format: format, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
    }

    private lazy var strikeThroughAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        let format = StrikethroughFormat()
        self.textView.toggle(format: format, selectedRange: selectedRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(format: format, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
    }

    private lazy var doneAction: UIAction = UIAction { _ in
        let paragraphs = [Paragraph](self.textView.attributedText!)

        let htmlTreeBuilder = HTMLTreeBuilder()
        for item in paragraphs {
            item.accept(visitor: htmlTreeBuilder)
        }
        let html = htmlTreeBuilder.toHtml()

        print("\n-------------")
        print(html)
        print("\n-------------")
//        print(attributedText.toHtml())
        self.resultTextView.text = html
        self.view.endEditing(true)

//        attributedText.enumerateAttributes(in: attributedText.fullRange) { attribute, range, _ in
//            print("log:: line start")
//            print(attributedText.attributedSubstring(from: range).string)
//            print(attribute)
//            print("log:: line end")
//        }
    }

    private func updateUndoRedoButtons() {
        undoButton.isEnabled = self.textView.undoManager?.canUndo ?? false
        redoButton.isEnabled = self.textView.undoManager?.canRedo ?? false
    }

    func textViewDidChange(_ textView: UITextView) {
        updateUndoRedoButtons()
    }
}
