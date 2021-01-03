import XCTest
@testable import Pin

final class PinTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Pin().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
