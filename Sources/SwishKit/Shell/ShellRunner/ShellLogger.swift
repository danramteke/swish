import Foundation
import Rainbow

class ShellLogger {
    enum Theme {
        case light, dark
    }

    func start(label: String, message: String) {
        let styledLabel = label.white.bold
        let styledMessage = message.lightWhite
        let combined = styledLabel + " " + styledMessage

        self.display(combined)
    }

    func nonZeroTermination(stdout: String, stderr: String) {
        let combined =
            "stdout".yellow + " " + stdout.lightWhite + "\n" +
            "stderr".yellow + " " + stderr.lightWhite

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
