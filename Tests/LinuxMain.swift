import XCTest

import SwiftyBuildTests

var tests = [XCTestCaseEntry]()
tests += SwiftyBuildTests.allTests()
XCTMain(tests)
