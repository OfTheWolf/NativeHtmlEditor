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

    private func makeToolbar() -> UIStackView {
        let topToolbar = UIToolbar()
        topToolbar.items = [
            UIBarButtonItem(image: UIImage(systemName: "bold"), primaryAction: boldAction),
            UIBarButtonItem(image: UIImage(systemName: "italic"), primaryAction: italicAction),
            UIBarButtonItem(image: UIImage(systemName: "underline"), primaryAction: underlineAction),
            UIBarButtonItem(image: UIImage(systemName: "strikethrough"), primaryAction: strikeThroughAction),
            UIBarButtonItem(image: UIImage(systemName: "text.alignleft"), primaryAction: leftAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.aligncenter"), primaryAction: centerAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.alignright"), primaryAction: rightAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.justify"), primaryAction: justifyAction),
            UIBarButtonItem(image: UIImage(systemName: "paintpalette"), primaryAction: foregroundColorAction),
            UIBarButtonItem(image: UIImage(systemName: "paintpalette.fill"), primaryAction: backgroundColorAction),
        ]
        topToolbar.sizeToFit()

        let bottomToolbar = UIToolbar()
        bottomToolbar.items = [
            undoButton,
            redoButton,
            .flexibleSpace(),
            UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
        ]

        let stackView = UIStackView(frame: .init(x: 0, y: 0, width: view.frame.width, height: topToolbar.frame.height*2))
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(topToolbar)
        stackView.addArrangedSubview(bottomToolbar)
        return stackView
    }

    private lazy var undoAction: UIAction = UIAction { _ in
        self.textView.undoManager?.undo()
        self.updateUndoRedoButtons()
    }

    private lazy var redoAction: UIAction = UIAction { _ in
        self.textView.undoManager?.redo()
        self.updateUndoRedoButtons()
    }

    private lazy var leftAlignAction: UIAction = UIAction { [unowned self] _ in
        alignAction(for: .left)
    }

    private lazy var rightAlignAction: UIAction = UIAction {[unowned self] _ in
        alignAction(for: .right)
    }

    private lazy var centerAlignAction: UIAction = UIAction {[unowned self] _ in
        alignAction(for: .center)
    }

    private lazy var justifyAction: UIAction = UIAction {[unowned self] _ in
        alignAction(for: .justified)
    }

    private func alignAction(for alignment: NSTextAlignment) {
        let selectedRange = self.textView.selectedRange
        let text = self.textView.text as NSString
        let paragraphRange = text.paragraphRange(for: self.textView.selectedRange)
        let mutableStyle = self.textView.typingAttributes[.paragraphStyle] as? NSMutableParagraphStyle
        guard let mutableStyle else { return }
        let format = TextAlignFormat(alignmet: alignment, currentParagraphStyle: mutableStyle)
        self.textView.toggle(paragraphFormat: format, selectedRange: paragraphRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(paragraphFormat: format, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
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
        let format = UnderlineFormat()
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

    private lazy var foregroundColorAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        let format = ForegroundColorFormat(color: .systemPink)
        self.textView.toggle(format: format, selectedRange: selectedRange)
        self.textView.undoManager?.registerUndo(withTarget: self, handler: { _ in
            self.textView.selectedRange = selectedRange
            self.textView.toggle(format: format, selectedRange: selectedRange)
        })
        self.updateUndoRedoButtons()
    }

    private lazy var backgroundColorAction: UIAction = UIAction { _ in
        let selectedRange = self.textView.selectedRange
        let format = BackgroundColorFormat(color: .yellow)
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

//@available(iOS 17.0, *)
//#Preview {
//    let size = UIScreen.main.bounds.size
//    let frame = CGRect(x: 20, y: 80, width: size.width-40, height: 200)
//    let view = UIView(frame: .zero)
//    let tv = UITextView(frame: frame)
//    view.addSubview(tv)
//    view.layer.borderColor = UIColor.label.cgColor
//    view.layer.borderWidth = 1
//    view.backgroundColor = .yellow
//    tv.backgroundColor = .secondarySystemGroupedBackground
//
//    let result = UITextView(frame: .init(x: 20, y: frame.maxY+12, width: frame.width, height: 200))
//    view.addSubview(result)
//
//    let html = """
//<p><strong>Title</strong></p>
//<ul>
//<li>item 1</li>
//<li>item 2</li>
//<li>item 3</li>
//</ul>
//&nbsp
//<p>The end</p>
//"""
//
//
//    class Delegate: NSObject, UITextViewDelegate {
//
//        func textViewDidChange(_ textView: UITextView) {
//            print
//        }
//    }
//
//    let attributedString = try! NSAttributedString(
//        data: html.data(using: .utf8)!,
//        options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
//        documentAttributes: nil
//    )
//    tv.delegate =
////    attributedString.enumerateAttributes(in: attributedString.fullRange) { attr, range, _ in
////        let ps = attr[.paragraphStyle] as! NSMutableParagraphStyle
////        let str = attributedString.attributedSubstring(from: range).string
////        print(str.map(\.description))
////    }
//    let ps = tv.typingAttributes[.paragraphStyle] as? NSMutableParagraphStyle
//    print(ps?.textLists)
//    tv.attributedText = attributedString
//    return view
//}
