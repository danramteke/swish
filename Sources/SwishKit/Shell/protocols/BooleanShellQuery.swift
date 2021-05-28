import Foundation

public protocol BooleanShellQuery: ParsableShellQuery where Output == Bool {
	var interpretation: BooleanStringInterpretation { get }
}

extension BooleanShellQuery {
	public var usesStdOut: Bool { true }
	
	public func parse(shellOutput: String) throws -> Output {
		self.interpretation.interpret(shellOutput: shellOutput)
	}
}

public enum BooleanStringInterpretation {
	case isEmpty
	case isNotEmpty
	case equals(String)
	case equalsTrimming(String)
	case contains(String)
	case notEquals(String)

	func interpret(shellOutput: String) -> Bool {
		switch self {
		case .isEmpty:
			return shellOutput.isEmpty
		case .isNotEmpty:
			return !shellOutput.isEmpty
		case .equals(let string):
			return string == shellOutput
		case .equalsTrimming(let string):
			return string == shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		case .contains(let string):
			return shellOutput.contains(string)
		case .notEquals(let string):
			return string != shellOutput
		}
	}
}

