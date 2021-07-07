import SwishDescription
import MPath
import Foundation

final class SwiftManifestLoader {
    func load(at path: Path) throws -> Swish {
        let workDir = path.parent() + "tmp/swish/workdir"
        try? workDir.delete()
        try workDir.parent().createDirectories()


        let resourcePath = Path(Bundle.module.bundlePath) + Path("ManifestLoading")

        try resourcePath.copy(to: workDir)
        try path.copy(to: workDir + "src/Swish.swift")


        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", "swift run --package-path \"\(workDir.absolute())\"" ]

        let outputPipe = Pipe()
        var outputData = Data()

        process.standardOutput = outputPipe
        process.standardError = FileHandle.standardError

        let outputQueue = DispatchQueue(label: "SwishManifestLoader")
        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                outputData.append(data)

            }
        }
        #endif

        try process.run()

        #if os(Linux)
        outputQueue.sync {
            outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

        }
        #endif

        process.waitUntilExit()

        guard 0 == process.terminationStatus else {
            throw NonZeroShellTermination(status: process.terminationStatus)
        }

        return try JSONDecoder().decode(Swish.self, from: outputData)
    }
}
