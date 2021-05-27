import Foundation

public protocol BooleanShellQuery: ParsableShellQuery where Output == Bool {
	var interpretation: BooleanStringInterpretation { get }
}

extension BooleanShellQuery {
	public func parse(shellOutput: String) throws -> Output {
		self.interpretation.interpret(shellOutput: shellOutput)
	}
}

public enum BooleanStringInterpretation {
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

