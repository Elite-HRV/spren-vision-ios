import XCTest
@testable import Spren

final class SprenTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Spren().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
