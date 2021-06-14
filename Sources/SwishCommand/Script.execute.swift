import SwishDescription
import Foundation
import MPath

extension Script {
    func run(in directory: Path) throws {
        switch self {
        case .text(let text):
            announce(text: text)
            try execute(text: text, in: directory)
        }
    }

    private func announce(text: String) {
        print()
        print("$ \(text)")
        print()
    }

    private func execute(text: String, in directory: Path) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", "cd \(directory) && \(text)"]

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
