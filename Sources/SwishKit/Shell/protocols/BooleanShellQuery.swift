import Foundation

public protocol BooleanShellQuery: ParsableShellQuery where Output == Bool {
	var interpretation: BooleanStringInterpretation { get }
}

extension BooleanShellQuery {

	public func parse(stdOutput: String) throws -> Output {
		self.interpretation.interpret(stdOutput: stdOutput)
	}
}

public enum BooleanStringInterpretation {
	case isEmpty
	case isNotEmpty
	case equals(String)
	case equalsTrimming(String)
	case contains(String)
	case notEquals(String)

	func interpret(stdOutput: String) -> Bool {
		switch self {
		case .isEmpty:
			return stdOutput.isEmpty
		case .isNotEmpty:
			return !stdOutput.isEmpty
		case .equals(let string):
			return string == stdOutput
		case .equalsTrimming(let string):
			return string == stdOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		case .contains(let string):
			return stdOutput.contains(string)
		case .notEquals(let string):
			return string != stdOutput
		}
	}
}

