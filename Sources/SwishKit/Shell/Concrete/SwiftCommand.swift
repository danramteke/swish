public struct SwiftCommand: ShellCommand {

    public let shellRunner: ShellRunner
    public let path: String
    public let target: String
    public let arguments: String

    public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
                path: String,
                target: String,
                arguments: String) {
        self.path = path
        self.target = target
        self.arguments = arguments
        self.shellRunner = shellRunner
    }

    public var text: String {
        "swift run --package-path \(path) \(target) \(arguments)"
    }
}
