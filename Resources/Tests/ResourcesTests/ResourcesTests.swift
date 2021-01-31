import XCTest
@testable import Resources

final class ResourcesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Resources().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
