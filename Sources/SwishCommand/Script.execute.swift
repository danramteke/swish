import SwishDescription
import Foundation

extension Script {
    func run() throws {
        switch self {
        case .text(let text):
            announce(text: text)
            try execute(text: text)
        }
    }

    private func announce(text: String) {
        print("$ \(text)")
        print()
    }

    private func execute(text: String) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", text]

        process.standardOutput = FileHandle.standardOutput
        process.standardError = FileHandle.standardError
        try process.run()
        process.waitUntilExit()

        if 0 != process.terminationStatus {
            throw NonZeroShellTermination(status: process.terminationStatus)
        }
    }
}

public struct NonZeroShellTermination: Error {
    public let status: Int32
}
