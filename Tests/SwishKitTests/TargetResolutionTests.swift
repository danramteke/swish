import XCTest
import Foundation
@testable import SwishKit

final class TargetResolutionTests: XCTestCase {

	var runner: ShellRunner!

	override func setUpWithError() throws {
		try super.setUpWithError()

		runner = ShellRunner()
	}

	func testResolvesA() throws {
			try runner.resolve(MyTargetID.a)
			XCTAssertEqual(runner.resolutionLog, [
											"MyTargetID.d",
											"MyTargetID.c",
											"MyTargetID.b",
											"MyTargetID.a"])
	}

	func testResolvesB() throws {
		try runner.resolve(MyTargetID.b)
		XCTAssertEqual(runner.resolutionLog, [
										"MyTargetID.d",
										"MyTargetID.c",
										"MyTargetID.b"])
	}

	func testResolvesC() throws {
		try runner.resolve(MyTargetID.c)
		XCTAssertEqual(runner.resolutionLog, ["MyTargetID.d", "MyTargetID.c"])
	}

	func testResolvesD() throws {
			try runner.resolve(MyTargetID.d)
			XCTAssertEqual(runner.resolutionLog, ["MyTargetID.d"])
	}
}

private enum MyTargetID: String, TargetID {
	case a, b, c, d

	var dependsOn: [Self] {
		switch self {
		case .a:
			return [.b]
		case .b:
			return [.c, .d]
		case .c:
			return [.d]
		case .d:
			return []
		}
	}

	var target: Target {
		switch self {
		case .a: return TargetA()
		case .b: return TargetB()
		case .c: return TargetC()
		case .d: return TargetD()
		}
	}

	struct TargetA: Target {
		func execute() throws { }
	}
	struct TargetB: Target {
		func execute() throws { }
	}
	struct TargetC: Target {
		func execute() throws { }
	}
	struct TargetD: Target {
		func execute() throws { }
	}
}
