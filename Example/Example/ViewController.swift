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

    private let manager = UndoManager()

    private let formatters: [NodeConverter] = [
        BoldItalicConverter(),
        UnderlineConverter(),
        StrikethroughConverter(),
        FontConverter()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputAccessoryView = makeToolbar()
        textView.delegate = self
        textView.attributedText = Mock.sample1.attributedString
        navigationItem.rightBarButtonItem = .init(systemItem: .refresh, primaryAction: .init(handler: { _ in
            self.textView.attributedText = Mock.sample1.attributedString
        }))
    }

    private func makeToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(image: UIImage(systemName: "text.alignleft"), primaryAction: leftAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.aligncenter"), primaryAction: centerAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.alignright"), primaryAction: rightAlignAction),
            UIBarButtonItem(image: UIImage(systemName: "text.justify"), primaryAction: justifyAction),
            UIBarButtonItem(image: UIImage(systemName: "bold"), primaryAction: boldAction),
            UIBarButtonItem(image: UIImage(systemName: "italic"), primaryAction: italicAction),
            UIBarButtonItem(image: UIImage(systemName: "underline"), primaryAction: underlineAction),
            UIBarButtonItem(image: UIImage(systemName: "strikethrough"), primaryAction: strikeThroughAction),
            UIBarButtonItem(image: UIImage(systemName: "increase.indent"), primaryAction: increaseIndentAction),
            UIBarButtonItem(image: UIImage(systemName: "decrease.indent"), primaryAction: deccreaseIndentAction),
            .flexibleSpace(),
            UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
        ]
        toolbar.sizeToFit()
        return toolbar
    }

    private lazy var increaseIndentAction: UIAction = UIAction { _ in

    }

    private lazy var deccreaseIndentAction: UIAction = UIAction { _ in

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
        self.textView.toggle(trait: .traitBold)
    }

    private lazy var italicAction: UIAction = UIAction { _ in
        self.textView.toggle(trait: .traitItalic)
    }

    private lazy var underlineAction: UIAction = UIAction { _ in
        self.textView.toggle(format: UnderlineFormat(), manager: self.manager)
    }

    private lazy var strikeThroughAction: UIAction = UIAction { _ in
        self.textView.toggle(format: StrikethroughFormat(), manager: self.manager)
    }

    private lazy var doneAction: UIAction = UIAction { _ in
        let attributedText = NSMutableAttributedString.init(attributedString: self.textView.attributedText!)
        let converter = AttributedStringToHtml(converters: self.formatters)
        let html = converter.convert(attributedText: attributedText, isPretty: true)
        print("\n-------------")
        print(html)
        print("\n-------------")
//        print(attributedText.toHtml())
        self.resultTextView.text = html
        self.view.endEditing(true)
    }

}
