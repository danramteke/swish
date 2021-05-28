import Foundation
import Rainbow

class ConsoleLogger {
	func warnChangingSettingsAfterStart() {
		let message = "Warning, editing settings after script has started is not supported".yellow
		self.display(message)
	}

	func start(label: String, message: String) {
		let styledLabel = label.cyan
		let styledMessage = message.bold
		let combined = styledLabel + " " + styledMessage

		self.display(combined)
	}

	func nonZeroTermination(stdout: String?, stderr: String?) {
		let combined =
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
