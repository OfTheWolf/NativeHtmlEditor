# NativeHtmlEditor

An HTML editor that converts `NSAttributedString` into HTML.

| Editor View | Html Output |
|:---:|:---:|
| <img src="Example/Example/editor.jpg" width="300"/> |  <img src="Example/Example/html.jpg" width="300"/> |


## Editing Features:
- Bold
- Italic
- Underlined
- Strikethrough
- Text color
- Text background color
- Text alignment
 
## Html Converter Features:
- Bold
- Italic
- Underlined
- Strikethrough
- Link
- Text color
- Text background color
- Text alignment
- List Items

# Usage

```swift
  let paragraphs = [Paragraph](self.textView.attributedText!)
  let htmlTreeBuilder = HTMLTreeBuilder()
  for item in paragraphs {
      item.accept(visitor: htmlTreeBuilder)
  }
  let html = htmlTreeBuilder.toHtml()
```
