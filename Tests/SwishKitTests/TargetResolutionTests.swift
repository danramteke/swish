import XCTest
import Foundation
@testable import SwishKit

final class TargetResolutionTests: XCTestCase {

	var resolver: TargetResolver!

	override func setUpWithError() throws {
		try super.setUpWithError()

		resolver = TargetResolver(logLevel: .debug)
	}

	func testResolvesA() throws {
			try resolver.resolve(MyTarget.a)
			XCTAssertEqual(resolver.resolutionLog, [
											"MyTarget.d",
											"MyTarget.c",
											"MyTarget.b",
											"MyTarget.a"])
	}

	func testResolvesB() throws {
		try resolver.resolve(MyTarget.b)
		XCTAssertEqual(resolver.resolutionLog, [
										"MyTarget.d",
										"MyTarget.c",
										"MyTarget.b"])
	}

	func testResolvesC() throws {
		try resolver.resolve(MyTarget.c)
		XCTAssertEqual(resolver.resolutionLog, ["MyTarget.d", "MyTarget.c"])
	}

	func testResolvesD() throws {
			try resolver.resolve(MyTarget.d)
			XCTAssertEqual(resolver.resolutionLog, ["MyTarget.d"])
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
		case .a: return nil
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
