import Foundation
import MPath

public protocol ShellOutputInitable {
	init(shellOutput: String) throws
}

extension RawRepresentable where RawValue == String {
	public init(shellOutput: String) throws {
		let trimmedOutput = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Self.init(rawValue: trimmedOutput) else {
			throw ShellOutputInitableParseError()
		}
		
		self = value
	}
}

extension String: ShellOutputInitable {
	public init(shellOutput: String) throws {
		self = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
	}
}

extension Int: ShellOutputInitable {
	public init(shellOutput: String) throws {
		let trimmedOutput = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Int(trimmedOutput) else {
			throw ShellOutputInitableParseError()
		}
		
		self = value
	}
}

extension Path: ShellOutputInitable {
	public init(shellOutput: String) throws {
		self.init(shellOutput.trimmingCharacters(in: .whitespacesAndNewlines))
	}
}

public struct ShellOutputInitableParseError: Error { }
