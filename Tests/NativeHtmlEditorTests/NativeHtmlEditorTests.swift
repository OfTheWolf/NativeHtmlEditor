import XCTest
@testable import NativeHtmlEditor

final class NativeHtmlEditorTests: XCTestCase {
    func testParagraph() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ElementNode(tag: .p, children: [TextNode(tag: .p, content: "hello")]).content, "<p>hello</p>")
    }
}
