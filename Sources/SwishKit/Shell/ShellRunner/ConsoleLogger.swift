import Foundation
import Rainbow

class ConsoleLogger {
	let isQuiet: Bool
	init(isQuiet: Bool) {
		self.isQuiet = isQuiet
	}

	func warnChangingSettingsAfterStart() {
		let message = "Warning, editing settings after script has started is not supported".yellow
		self.display(message)
	}

	func start(label: String, message: String) {
		if isQuiet { return }

		let styledLabel = label.cyan
		let styledMessage = message.bold
		let combined = styledLabel + " " + styledMessage

		self.display(combined)
	}

	func nonZeroTermination(cmd: String, stdout: String?, stderr: String?) {
		let combined =
			"non-zero termination of:\n" +
			"\(cmd)\n" +
			"stdout".yellow + " " + (stdout ?? "empty".italic) + "\n" +
			"stderr".yellow + " " + (stderr ?? "empty".italic)

		self.display(combined)
	}

	private func display(_ string: String) {
		queue.async {
			print(string)
		}
	}

	private let queue = DispatchQueue(
		label: "ShellLogger.\(UUID().uuidString)",
		qos: .utility,
		attributes: [],
		autoreleaseFrequency: .inherit,
		target: .global())
}
