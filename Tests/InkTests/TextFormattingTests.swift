/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Ink

final class TextFormattingTests: XCTestCase {
    func testParagraph() {
        let html = MarkdownParser().html(from: "Hello, world!")
        XCTAssertEqual(html, "<p>Hello, world!</p>")
    }

    func testItalicText() {
        let html = MarkdownParser().html(from: "Hello, *world*!")
        XCTAssertEqual(html, "<p>Hello, <em>world</em>!</p>")
    }

    func testBoldText() {
        let html = MarkdownParser().html(from: "Hello, **world**!")
        XCTAssertEqual(html, "<p>Hello, <strong>world</strong>!</p>")
    }

    func testItalicBoldText() {
        let html = MarkdownParser().html(from: "Hello, ***world***!")
        XCTAssertEqual(html, "<p>Hello, <strong><em>world</em></strong>!</p>")
    }

    func testItalicBoldTextWithSeparateStartMarkers() {
        let html = MarkdownParser().html(from: "**Hello, *world***!")
        XCTAssertEqual(html, "<p><strong>Hello, <em>world</em></strong>!</p>")
    }

    func testItalicTextWithinBoldText() {
        let html = MarkdownParser().html(from: "**Hello, *world*!**")
        XCTAssertEqual(html, "<p><strong>Hello, <em>world</em>!</strong></p>")
    }

    func testBoldTextWithinItalicText() {
        let html = MarkdownParser().html(from: "*Hello, **world**!*")
        XCTAssertEqual(html, "<p><em>Hello, <strong>world</strong>!</em></p>")
    }

    func testItalicTextWithExtraLeadingMarkers() {
        let html = MarkdownParser().html(from: "**Hello*")
        XCTAssertEqual(html, "<p>*<em>Hello</em></p>")
    }

    func testBoldTextWithExtraLeadingMarkers() {
        let html = MarkdownParser().html(from: "***Hello**")
        XCTAssertEqual(html, "<p><strong>*Hello</strong></p>")
    }

    func testItalicTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "*Hello**")
        XCTAssertEqual(html, "<p><em>Hello</em>*</p>")
    }

    func testBoldTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "**Hello***")
        XCTAssertEqual(html, "<p><strong>Hello</strong>*</p>")
    }

    func testItalicBoldTextWithExtraTrailingMarkers() {
        let html = MarkdownParser().html(from: "**Hello, *world*****!")
        XCTAssertEqual(html, "<p><strong>Hello, <em>world</em></strong>**!</p>")
    }

    func testUnterminatedItalicMarker() {
        let html = MarkdownParser().html(from: "*Hello")
        XCTAssertEqual(html, "<p>*Hello</p>")
    }

    func testUnterminatedBoldMarker() {
        let html = MarkdownParser().html(from: "**Hello")
        XCTAssertEqual(html, "<p>**Hello</p>")
    }

    func testUnterminatedItalicBoldMarker() {
        let html = MarkdownParser().html(from: "***Hello")
        XCTAssertEqual(html, "<p>***Hello</p>")
    }

    func testUnterminatedItalicMarkerWithinBoldText() {
        let html = MarkdownParser().html(from: "**Hello, *world!**")
        XCTAssertEqual(html, "<p><strong>Hello, *world!</strong></p>")
    }

    func testUnterminatedBoldMarkerWithinItalicText() {
        let html = MarkdownParser().html(from: "*Hello, **world!*")
        XCTAssertEqual(html, "<p><em>Hello, **world!</em></p>")
    }

    func testStrikethroughText() {
        let html = MarkdownParser().html(from: "Hello, ~~world!~~")
        XCTAssertEqual(html, "<p>Hello, <s>world!</s></p>")
    }

    func testSingleTildeWithinStrikethroughText() {
        let html = MarkdownParser().html(from: "Hello, ~~wor~ld!~~")
        XCTAssertEqual(html, "<p>Hello, <s>wor~ld!</s></p>")
    }

    func testUnterminatedStrikethroughMarker() {
        let html = MarkdownParser().html(from: "~~Hello")
        XCTAssertEqual(html, "<p>~~Hello</p>")
    }

    func testEncodingSpecialCharacters() {
        let html = MarkdownParser().html(from: "Hello < World & >")
        XCTAssertEqual(html, "<p>Hello &lt; World &amp; &gt;</p>")
    }

    func testSingleLineBlockquote() {
        let html = MarkdownParser().html(from: "> Hello, world!")
        XCTAssertEqual(html, "<blockquote><p>Hello, world!</p></blockquote>")
    }

    func testMultiLineBlockquote() {
        let html = MarkdownParser().html(from: """
        > One
        > Two
        > Three
        """)

        XCTAssertEqual(html, "<blockquote><p>One Two Three</p></blockquote>")
    }

    func testEscapingSymbolsWithBackslash() {
        let html = MarkdownParser().html(from: """
        \\# Not a title
        \\*Not italic\\*
        """)

        XCTAssertEqual(html, "<p># Not a title *Not italic*</p>")
    }
}

extension TextFormattingTests {
    static var allTests: [(String, TestClosure<TextFormattingTests>)] {
        return [
            ("testParagraph", testParagraph),
            ("testItalicText", testItalicText),
            ("testBoldText", testBoldText),
            ("testItalicBoldText", testItalicBoldText),
            ("testItalicBoldTextWithSeparateStartMarkers", testItalicBoldTextWithSeparateStartMarkers),
            ("testItalicTextWithinBoldText", testItalicTextWithinBoldText),
            ("testBoldTextWithinItalicText", testBoldTextWithinItalicText),
            ("testItalicTextWithExtraLeadingMarkers", testItalicTextWithExtraLeadingMarkers),
            ("testBoldTextWithExtraLeadingMarkers", testBoldTextWithExtraLeadingMarkers),
            ("testItalicTextWithExtraTrailingMarkers", testItalicTextWithExtraTrailingMarkers),
            ("testBoldTextWithExtraTrailingMarkers", testBoldTextWithExtraTrailingMarkers),
            ("testItalicBoldTextWithExtraTrailingMarkers", testItalicBoldTextWithExtraTrailingMarkers),
            ("testUnterminatedItalicMarker", testUnterminatedItalicMarker),
            ("testUnterminatedBoldMarker", testUnterminatedBoldMarker),
            ("testUnterminatedItalicBoldMarker", testUnterminatedItalicBoldMarker),
            ("testUnterminatedItalicMarkerWithinBoldText", testUnterminatedItalicMarkerWithinBoldText),
            ("testUnterminatedBoldMarkerWithinItalicText", testUnterminatedBoldMarkerWithinItalicText),
            ("testStrikethroughText", testStrikethroughText),
            ("testSingleTildeWithinStrikethroughText", testSingleTildeWithinStrikethroughText),
            ("testUnterminatedStrikethroughMarker", testUnterminatedStrikethroughMarker),
            ("testEncodingSpecialCharacters", testEncodingSpecialCharacters),
            ("testSingleLineBlockquote", testSingleLineBlockquote),
            ("testMultiLineBlockquote", testMultiLineBlockquote),
            ("testEscapingSymbolsWithBackslash", testEscapingSymbolsWithBackslash)
        ]
    }
}
