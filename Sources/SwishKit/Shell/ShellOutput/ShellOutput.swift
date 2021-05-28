import MPath

public struct ShellOutput {
    public let stdOut: Path
    public let stdErr: Path
    public let status: Int32
}

extension ShellOutput {
    public func stdOutput() throws -> String {
        try stdOut.read(encoding: .utf8)
    }

    public func stdError() throws -> String {
        try stdErr.read(encoding: .utf8)
    }
}
