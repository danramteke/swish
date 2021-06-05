import XCTest 
@testable import ExampleApp

final class EnvTests: XCTestCase {
    func testCurrentEnvironment() {
        XCTAssertEqual(Env.current, .unittest)
    }
}
