import Foundation

public protocol BooleanShellQuery: ParsableShellQuery where Output == Bool {
	var interpretation: BooleanStringInterpretation { get }
}

extension BooleanShellQuery {

	public func parse(string: String) throws -> Output {
		self.interpretation.interpret(string: string)
	}
}

public enum BooleanStringInterpretation {
	case isEmpty
	case isNotEmpty
	case equals(String)
	case equalsTrimming(String)
	case contains(String)
	case notEquals(String)

	func interpret(string input: String) -> Bool {
		switch self {
		case .isEmpty:
			return input.isEmpty
		case .isNotEmpty:
			return !input.isEmpty
		case .equals(let string):
			return string == input
		case .equalsTrimming(let string):
			return string == input.trimmingCharacters(in: .whitespacesAndNewlines)
		case .contains(let string):
			return input.contains(string)
		case .notEquals(let string):
			return string != input
		}
	}
}
