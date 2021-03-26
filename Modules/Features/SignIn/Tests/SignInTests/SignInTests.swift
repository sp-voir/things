import XCTest
@testable import SignIn

final class SignInTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SignIn().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
