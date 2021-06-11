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
			try runner.resolve(MyTarget.a)
			XCTAssertEqual(runner.resolutionLog, [
											"MyTarget.d",
											"MyTarget.c",
											"MyTarget.b",
											"MyTarget.a"])
	}

	func testResolvesB() throws {
		try runner.resolve(MyTarget.b)
		XCTAssertEqual(runner.resolutionLog, [
										"MyTarget.d",
										"MyTarget.c",
										"MyTarget.b"])
	}

	func testResolvesC() throws {
		try runner.resolve(MyTarget.c)
		XCTAssertEqual(runner.resolutionLog, ["MyTarget.d", "MyTarget.c"])
	}

	func testResolvesD() throws {
			try runner.resolve(MyTarget.d)
			XCTAssertEqual(runner.resolutionLog, ["MyTarget.d"])
	}
}

private enum MyTarget: String, Target {
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

	var command: Command? {
		switch self {
		case .a: return TargetA()
		case .b: return TargetB()
		case .c: return TargetC()
		case .d: return TargetD()
		}
	}

	struct TargetA: Command {
		func execute() throws { }
	}
	struct TargetB: Command {
		func execute() throws { }
	}
	struct TargetC: Command {
		func execute() throws { }
	}
	struct TargetD: Command {
		func execute() throws { }
	}
}
