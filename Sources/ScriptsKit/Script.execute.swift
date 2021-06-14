import ScriptsDescription
import Foundation

extension Script {
    func execute() throws {
        switch self {
        case .text(let text):
            print("$ \(text)")
            print()

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
}

public struct NonZeroShellTermination: Error {
    public let status: Int32
}
