import MPath

extension Path: ShellOutputInitable {}
extension Path: StdOutputInitable {

    public init(stdOutput: String) {
        self.init(stdOutput.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
