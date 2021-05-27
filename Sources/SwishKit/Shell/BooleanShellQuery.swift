import Foundation

public struct BooleanShellQuery: ParsableShellQuery {
	public typealias Output = Bool
	public let text: String
	public let interpretation: Interpretation

	public init(_ text: String, interpretation: Interpretation) {
		self.text = text
		self.interpretation = interpretation
	}

	public func parse(shellOutput: String) throws -> Output {
		self.interpretation.interpret(shellOutput: shellOutput)
	}
}

extension BooleanShellQuery {
	public enum Interpretation {
		case isEmpty
		case isNotEmpty
		case equals(String)
		case notEquals(String)

		func interpret(shellOutput: String) -> Bool {
			switch self {
			case .isEmpty:
				return shellOutput.isEmpty
			case .isNotEmpty:
				return !shellOutput.isEmpty
			case .equals(let string):
				return string == shellOutput
			case .notEquals(let string):
				return string != shellOutput
			}
		}
	}
}

